import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghumfir_f/Components/DialogPrompt.dart';
import 'package:http/http.dart';

import '../Models/chat_model.dart';
import '../MyHomePage/SignInScreen.dart';
import '../api.dart';

class ChatService {
  Future<List<ChatModel>> getChats(int page) async {
    Response res = await get(
      Uri.parse("${Api.baseUrl}bot/$page"),
      headers: Api.header,
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> messages = body["data"]["messages"];
      return messages.map((e) => ChatModel.fromJson(e)).toList();
    } else {
      throw "${res.statusCode}: ${res.body}";
    }
  }

  Future<(ChatModel? chat, bool isAuthenticated)> sendMessage(
      String textMessage, BuildContext context) async {
    Response res = await post(
      Uri.parse("${Api.baseUrl}bot/"),
      body: jsonEncode({"message": textMessage.trim()}),
      headers:{
        "content-type": "application/json",
        if (Api.token != null) "Authorization": "Token ${Api.token}",
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return (ChatModel.fromJson(body["data"]["reply"]), true);
    } else if (res.statusCode == 401) {
      return (null, false);
    } else {
      print("${res.statusCode}: ${res.body}");
      DialogPrompt.showSnackbar(res.body.toString(), context);
      return (null, true);
    }
  }
}
