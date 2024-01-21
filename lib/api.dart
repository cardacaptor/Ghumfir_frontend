import 'package:shared_preferences/shared_preferences.dart';



class Api {
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static String get baseUrl => "http://127.0.0.1:8000/";

  static Map<String, String> get header => {
        "content-type": "application/json",
        if (token != null) "Authorization": "Token $token",
      };

  static String? _token;

  static set token(String? value) {
    _token = value;
    if (value == null) return;
    setToken(value);
  }

  static String? get token => _token;

  static Future<String?> loadToken() async {
    _token = (await prefs).getString("token");
    return _token;
  }

  static Future<void> setToken(String value) async =>
      (await prefs).setString("token", value);
}
