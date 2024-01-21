import 'package:ghumfir_f/Models/post_model.dart';

class ChatModel {
  final String message;
  final List<ChatPostModel> posts;
  final bool isFromBot;

  ChatModel(this.message, this.posts, this.isFromBot);

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      json["message"],
      (json["posts"] as List<dynamic>)
          .map((e) => ChatPostModel.fromJson(e))
          .toList(),
      json["isBotMessage"],
    );
  }
}

class ChatPostModel {
  final PostModel post;

  ChatPostModel(this.post);

  factory ChatPostModel.fromJson(Map<String, dynamic> json) {
    return ChatPostModel(PostModel.fromJson(json["post"]));
  }
}
