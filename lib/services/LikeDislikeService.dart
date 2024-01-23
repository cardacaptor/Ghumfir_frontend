// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:ghumfir_f/Models/post_model.dart';
// import 'package:ghumfir_f/api.dart';
// import 'package:http/http.dart';
//
// class LikeDislikeService {
//   Future<List<PostModel>> likePost(int post_id, BuildContext context) async {
//     Response res = await post(
//       Uri.parse("${Api.baseUrl}feed/$post_id/like"),
//       headers: Api.header,
//     );
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       Map<String, dynamic> data = json.decode(res.body);
//       return data['likes'];
//     } else {
//       throw Exception('Failed to like the message');
//     }
//   }
// }
