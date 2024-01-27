import 'package:flutter/material.dart';
import 'package:ghumfir_f/Models/chat_model.dart';
import 'package:ghumfir_f/api.dart';
import 'package:ghumfir_f/services/ChatService.dart';

import 'SignInScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController controller = ScrollController();
  List<ChatModel> _messages = [];
  int page = 1;
  late Future<List<ChatModel>> future = ChatService().getChats(1, context);

  bool disable = false;
  bool limitReached = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 34, 33, 33),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Image.asset(
              "assets/images/Logo.png",
              width: 230,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Api.token == null
                ? Center(
                    child: ElevatedButton(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: const SignInScreen(),
                                backgroundColor:
                                    Color.fromARGB(255, 34, 33, 33),
                              ),
                            ),
                        child: const Text("Login")),
                  )
                : FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        if (!snapshot.error.toString().contains("401")) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        return const Center(
                          child: Text("Login to fetch previous messages"),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      _messages = snapshot.data!;
                      return ListView.builder(
                        controller: controller,
                        reverse: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message =
                              _messages[_messages.length - index - 1];
                          return MessageWidget(
                            message: message,
                          );
                        },
                      );
                    }),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: _messageController,
        onSubmitted: (_) => _sendMessage(context),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              _sendMessage(context);
            },
          ),
          hintText: 'Text your personal assistant',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _sendMessage(BuildContext context) async {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(ChatModel(messageText, [], false));
      });
      _messageController.clear();
      (ChatModel?, bool) reply =
          await ChatService().sendMessage(messageText, context);
      if (reply.$1 != null) {
        _messages.add(reply.$1!);
      } else {
        _messages.clear();
        if (!reply.$2) {
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: SignInScreen(),
              backgroundColor: Color.fromARGB(255, 34, 33, 33),
            ),
          );
          setState(() {
            future = ChatService().getChats(1, context);
          });
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    Api.tokenListeners.add((prev, curr) => mounted ? setState(() {}) : 1);
    controller.addListener(() async {
      if (controller.position.pixels >
              controller.position.maxScrollExtent - 100 &&
          !disable &&
          !limitReached) {
        disable = true;
        page++;
        final list = await ChatService().getChats(page, context);
        if (list.length < 20) {
          limitReached = true;
        }
        setState(() {
          _messages.insertAll(0, list);
        });
        disable = false;
      }
    });
  }
}

class MessageWidget extends StatelessWidget {
  final ChatModel message;

  MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          !message.isFromBot ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: !message.isFromBot
              ? Color.fromARGB(255, 146, 122, 16)
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: message.posts.isEmpty
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                message.message,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            if (message.posts.isNotEmpty) SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: message.posts
                    .map(
                      (e) => Builder(builder: (ctx) {
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          width: 300,
                          height: 300,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          padding: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Theme.of(context).cardColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  ("${Api.baseUrl}${e.post.url}").replaceFirst(
                                      RegExp(r'(?<=:\/\/[^\/]+)\/{2}'), '/'),
                                  height: 200,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.post.caption,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                    ),
                                    if (e.post.price != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            height: 1,
                                            width:
                                                MediaQuery.of(ctx).size.width,
                                            color: Colors.lightGreen
                                                .withOpacity(0.5),
                                          ),
                                          Text(
                                            "NPR ${e.post.price}",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
