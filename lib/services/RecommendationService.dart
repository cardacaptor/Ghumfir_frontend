import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ghumfir_f/Models/post_model.dart';
import 'package:http/http.dart';

import '../api.dart';

class RecommendationService {
  Future<List<PostModel>?> fetchFeed(int page, BuildContext context) async {
    Response res = await get(
      Uri.parse("${Api.baseUrl}feed/$page"),
      headers: Api.header,
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> response = jsonDecode(res.body);
      List<dynamic> data = response["data"];
        return data.map((e) => PostModel.fromJson(e)).toList();
    }
    res.handleErrors(context);
    return null;
  }
}
