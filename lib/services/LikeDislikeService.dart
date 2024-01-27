import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ghumfir_f/Models/post_model.dart';
import 'package:ghumfir_f/api.dart';
import 'package:http/http.dart';

class LikeDislikeService {
  Future<PostModel?> likePost(int postId, BuildContext context) async {
    print( Api.header);
    Response res = await post(
      Uri.parse("${Api.baseUrl}feed/post/$postId/like"),
      headers: Api.header,
    );
    print(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> data = json.decode(res.body);
      return PostModel.fromJson(data['data']);
    } else {
      res.handleErrors(context);
    }
  }

  Future<PostModel?> dislikePost(int postId, BuildContext context) async {
    Response res = await post(
      Uri.parse("${Api.baseUrl}feed/post/$postId/dislike"),
      headers: Api.header,
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> data = json.decode(res.body);
      return PostModel.fromJson(data['data']);
    } else {
      res.handleErrors(context);
    }
  }
}
