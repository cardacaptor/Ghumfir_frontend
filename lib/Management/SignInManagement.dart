import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ghumfir_f/Models/user_model.dart';

import '../api.dart';
import '../services/AuthService.dart';

class SignInManagement with ChangeNotifier, DiagnosticableTreeMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? usernameError;
  String? passwordError;
  bool _isPasswordVisible = false;

  bool isConfirmButtonPressed = false;
  bool createButtonEnabled = false;

  clearState() {
    usernameController.text = "";
    passwordController.text = "";
    usernameError = null;
    passwordError = null;
    _isPasswordVisible = false;
    isConfirmButtonPressed = false;
    createButtonEnabled = false;
    notifyListeners();
  }

  bool validateUsername() {
    if (usernameController.text.isEmpty) {
      usernameError = "Please enter username";
      return false;
    } else {
      usernameError = null;
      return true;
    }
    // RegExp regExpEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    // if (usernameController.text.isEmpty) {
    //   usernameError = "Please enter email";
    //   return false;
    // } else if (!regExpEmail.hasMatch(usernameController.text)) {
    //   usernameError = "Please enter valid email";
    //   return false;
    // } else {
    //   usernameError = null;
    //   return true;
    // }
  }

  bool validatePassword() {
    if (passwordController.text.isNotEmpty) {
      passwordError = null;
      return true;
    } else {
      passwordError = "Password cannot be empty";
      return false;
    }
  }

  bool validate() {
    bool user = validateUsername();
    bool password = validatePassword();
    createButtonEnabled = user && password;
    notifyListeners();
    return createButtonEnabled;
  }

  Future<bool> logInToAccount(BuildContext context) async {
    isConfirmButtonPressed = true;
    bool isValidated = validate();
    if (isValidated) {
      NavigatorState navigator = Navigator.of(context);
      (String, UserModel)? token = await AuthService()
          .signIn(usernameController.text, passwordController.text, context);
      if (token != null) {
        Api.settokenWithUser(token.$1, user: token.$2);
        navigator.pop();
      }
    }
    return Future.value(false);
  }

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }
}
