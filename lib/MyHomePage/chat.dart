import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ghumfir_f/Models/chat_model.dart';
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
  Future<List<ChatModel>> future = ChatService().getChats(1);

  bool disable = false;
  bool limitReached = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
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
                    final message = _messages[_messages.length - index - 1];
                    return MessageWidget(
                      message: message,
                    );
                  },
                );
              }),
        ),
        _buildMessageInput(context),
      ],
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              onSubmitted: (_) => _sendMessage(context),
              decoration: const InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendMessage(context);
            },
          ),
        ],
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
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
          );
          setState(() {
            future = ChatService().getChats(1);
          });
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() async {
      if (controller.position.pixels >
              controller.position.maxScrollExtent - 100 &&
          !disable &&
          !limitReached) {
        disable = true;
        page++;
        final list = await ChatService().getChats(page);
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
          color: !message.isFromBot ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
            ...message.posts.map((e) => Text(e.post.caption))
          ],
        ),
      ),
    );
  }
}
