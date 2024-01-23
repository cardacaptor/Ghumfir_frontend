import 'package:ghumfir_f/Models/user_model.dart';

enum PostAction {
  LK,
  DL;

  factory PostAction.fromJson(String json) {
    if (json == "LK") return LK;
    return DL;
  }
}

class PostActionModel {
  final UserModel user;
  final PostAction? action;
  PostActionModel(this.user, this.action);
  factory PostActionModel.fromJson(Map<String, dynamic> json) {
    return PostActionModel(
      UserModel.fromJson(json["user"]),
      json["action"] == null
          ? null
          : PostAction.fromJson(
              json["action"]!,
            ),
    );
  }
}
