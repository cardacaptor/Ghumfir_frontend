import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ghumfir_f/Models/post_model.dart';
import 'package:http/http.dart';

import '../api.dart';

class RecommendationService {
  Future<(List<PostModel>, int)?> fetchFeed(int page, BuildContext context,
      {int sessionId = 0}) async {
    page = 1;
    Response res = await get(
      Uri.parse("${Api.baseUrl}feed/landing/$page/session/$sessionId"),
      headers: Api.header,
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> response = jsonDecode(res.body);
      List<dynamic> data = response["data"];
      List<PostModel> posts = data.map((e) => PostModel.fromJson(e)).toList();
      int sessionId = int.tryParse(response["session_id"].toString()) ?? 0;
      return (posts, sessionId);
    }
    res.handleErrors(context);
    return null;
  }

  Future<List<PostModel>?> searchFeed(int page, String search) async {
    Response res = await get(
      Uri.parse("${Api.baseUrl}feed/landing/$page/$search"),
      headers: Api.header,
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> response = jsonDecode(res.body);
      List<dynamic> data = response["data"];
      List<PostModel> posts = data.map((e) => PostModel.fromJson(e)).toList();
      return posts;
    }
    return null;
  }
}
