import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghumfir_f/Components/DialogPrompt.dart';
import 'package:ghumfir_f/Models/user_model.dart';

import '../api.dart';
import '../services/AuthService.dart';

class SignUpManagement with ChangeNotifier, DiagnosticableTreeMixin {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool _isPasswordVisible = false;
  int? passwordStrength; //denoting 5 as strongest and 1 as weakest
  Color? passwordStrengthColor;
  String? passwordStrengthText;

  bool isConfirmButtonPressed = false;
  bool _confirmEnabled = false;
  bool _termsCheckBox = false;
  bool createButtonEnabled = false;

  Random rand = Random();
  String? firstNameError;
  String? emailError;
  String? passwordError;
  String? confirmError;

  clearState() {
    firstNameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    confirmController.text = "";

    _isPasswordVisible = false;
    passwordStrength = null;
    passwordStrengthColor = null;
    passwordStrengthText = null;

    isConfirmButtonPressed = false;
    _confirmEnabled = false;
    _termsCheckBox = false;
    createButtonEnabled = false;

    firstNameError = null;
    emailError = null;
    passwordError = null;
    confirmError = null;
  }

  bool validateFirstName() {
    if (firstNameController.text.isNotEmpty) {
      firstNameError = null;
      return true;
    } else {
      firstNameError = "Please enter your first name";
      return false;
    }
  }

  bool validateEmail() {
    RegExp regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (emailController.text.isEmpty) {
      emailError = "Please enter your email address";
      return false;
    } else if (!regExp.hasMatch(emailController.text)) {
      emailError = "Please enter valid email address";
      return false;
    } else {
      emailError = null;
      return true;
    }
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

  bool validateConfirmPassword() {
    if (confirmController.text == passwordController.text) {
      confirmError = null;
      return true;
    } else {
      confirmError = "Password don't match";
      return false;
    }
  }

  bool validate() {
    bool firstName = validateFirstName();
    bool email = validateEmail();
    bool password = validatePassword();
    bool confirmPassword = validateConfirmPassword();
    createButtonEnabled =
        firstName && email && password && confirmPassword && _termsCheckBox;
    notifyListeners();
    return createButtonEnabled;
  }

  // The password is at least 8 characters long (?=.{8,})
  // The password has at least one uppercase letter (?=.*[A-Z])
  // The password has at least one lowercase letter (?=.*[a-z])
  // The password has at least one digit (?=.*[0-9])
  // The password has at least one special character ([^A-Za-z0-9]).

  //level one is not 8 characters
  //level one is case insensitive
  //level two is alphanumeric case insensitive
  //level three is case sensitive
  //level four is case sensitive alphanumeric
  //rest is level five special character
  testPasswordStrength() {
    String value = passwordController.text;
    bool eightCharacters = RegExp(r'(?=.{8,})').hasMatch(value);
    bool uppercasePresence = RegExp(r'(?=.*[A-Z])').hasMatch(value);
    bool lowercasePresence = RegExp(r'(?=.*[a-z])').hasMatch(value);
    bool digitPresence = RegExp(r'(?=.*[0-9])').hasMatch(value);
    bool specialCharacterPresence = RegExp(r'([^A-Za-z0-9])').hasMatch(value);

    if (value.isEmpty) {
      passwordStrength = null;
    } else if (eightCharacters) {
      if ((digitPresence && uppercasePresence && lowercasePresence) &&
          specialCharacterPresence) {
        passwordStrength = 5;
      } else if ((uppercasePresence && lowercasePresence && digitPresence) ||
          specialCharacterPresence) {
        passwordStrength = 4;
      } else if ((uppercasePresence && lowercasePresence) ||
          (digitPresence && uppercasePresence || lowercasePresence)) {
        passwordStrength = 3;
      } else {
        passwordStrength = 2;
      }
    } else {
      passwordStrength = 1;
    }

    // passwordStrength = passwordStrength == 5 ? 1 : (passwordStrength ?? 0) + 1;
    if (passwordStrength == null || passwordStrength == 0) {
      passwordStrengthColor = null;
      passwordStrengthText = null;
    } else if (passwordStrength == 1) {
      passwordStrengthColor = Color(0XFFFF0000);
      passwordStrengthText = "Weakest";
    } else if (passwordStrength == 2) {
      passwordStrengthColor = Color(0XFFF45B00);
      passwordStrengthText = "Weak";
    } else if (passwordStrength == 3) {
      passwordStrengthColor = Color(0XFFEAB600);
      passwordStrengthText = "Medium";
    } else if (passwordStrength == 4) {
      passwordStrengthColor = Color(0XFF8BB100);
      passwordStrengthText = "Strong";
    } else if (passwordStrength == 5) {
      passwordStrengthColor = Color(0XFF2DAC00);
      passwordStrengthText = "Strongest";
    }
    notifyListeners();
  }

  Future<bool> createAccount(BuildContext context) async {
    isConfirmButtonPressed = true;
    bool isValidated = validate();
    if (!_termsCheckBox) {
      DialogPrompt.showSnackbar("Please agree to terms and policy", context);
      return false;
    }
    if (isValidated) {
      NavigatorState navigator = Navigator.of(context);
      if ((passwordStrength ?? 0) < 2) {
        DialogPrompt.showSnackbar("The password provided is too weak", context);
        return false;
      }
      (String, UserModel)? token = await AuthService().signUp(
        firstNameController.text,
        emailController.text,
        passwordController.text,
        context,
      );
      if (token != null) {
        DialogPrompt.showSnackbar("Signed Up", context);
        Api.settokenWithUser(token.$1, user: token.$2);
        navigator.pop();
      }
    }
    return Future.value(false);
  }

  bool get termsCheckBox => _termsCheckBox;

  set termsCheckBox(bool value) {
    _termsCheckBox = value;
    notifyListeners();
  }

  bool get confirmEnabled => _confirmEnabled;

  set confirmEnabled(bool value) {
    _confirmEnabled = value;
    notifyListeners();
  }

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }
}
