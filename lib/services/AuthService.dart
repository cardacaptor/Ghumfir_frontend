import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ghumfir_f/api.dart';
import 'package:http/http.dart';

class AuthService {
  Future<String?> signIn(
    String username,
    String password,
    BuildContext context,
  ) async {
    final String apiUrl = "${Api.baseUrl}auth/signin";
    final response = await post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['data']['token'];

      print('SignIn Successful');
      print('Token: $token');
      return token;
    } else {
      response.handleErrors(context);
      return null;
    }
  }

  Future<String?> signUp(
    String username,
    String email,
    String password,
    BuildContext context,
  ) async {
    final String apiUrl = "${Api.baseUrl}auth/signup";
    final response = await post(Uri.parse(apiUrl),
        headers: Api.header,
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String? token = responseData['data']['token'];

      if (token != null) {
        print("Sign-up successful! Token: $token");
        return token;
      } else {
        print("Sign-up failed: Token missing in the response");
        return null;
      }
    } else {
      response.handleErrors(context);
      print("Sign-up failed: ${response.reasonPhrase}");
      return null;
    }
  }
}
