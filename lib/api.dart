import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Components/DialogPrompt.dart';
import 'Models/user_model.dart';
import 'MyHomePage/SignInScreen.dart';

class Api {
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static String get baseUrl => "http://127.0.0.1:8000/";

  static Map<String, String> get header => {
        "content-type": "application/json",
        if (token != null) "Authorization": "Token $token",
      };

  static String? _token;

  static UserModel? _user;

  static settokenWithUser(String? value, {UserModel? user}) {
    _token = value;
    if (value == null) return;
    _user = user;
    setToken(value, user: user);
  }

  static String? get token => _token;

  static UserModel? get user => _token == null ? null : _user;

  static Future<String?> loadToken() async {
    String? token = (await prefs).getString("token");
    String? userEncoded = (await prefs).getString("user");
    if (userEncoded != null && token != null) {
      _token = token;
      _user = UserModel.fromJson(jsonDecode(userEncoded));
    }
    return _token;
  }

  static Future<void> setToken(String? value, {UserModel? user}) async {
    for (var i in tokenListeners) {
      i(_token, value);
    }
    print("_token $_token");
    print("_value $value");
    _token = value;
    if (value == null) {
      (await prefs).remove("token");
      (await prefs).remove("user");
      return;
    }
    (await prefs).setString("token", value);
    (await prefs).setString("user", user.toString());
  }

  static List<Function(String? prev, String? curr)> tokenListeners = [];
}

extension Handle on Response {
  handleErrors(BuildContext context) {
    if (statusCode == 401) {
      Api.setToken(null);
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const SignInScreen(),
          backgroundColor: Color.fromARGB(255, 34, 33, 33),
        ),
      );
    }
    Map<String, dynamic> body = jsonDecode(this.body);
    if (body["errors"] != null) {
      print(body["errors"]);
      log(body["errors"]);
      if (body["errors"].toString().toLowerCase().contains("token")) {
        Api.setToken(null);
        return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: const SignInScreen(),
            backgroundColor: Color.fromARGB(255, 34, 33, 33),
          ),
        );
      }
      DialogPrompt.showSnackbar(body["errors"].toString(), context);
    } else if (body["data"] != null) {
      print(body["data"]);
      log(body["data"]);
      DialogPrompt.showSnackbar(body["data"].toString(), context);
    } else {
      print(body.toString());
      log(body.toString());
      throw body.toString();
    }
  }
}
