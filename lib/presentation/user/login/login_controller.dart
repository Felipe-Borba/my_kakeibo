import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  // Dependencies

  // State
  String? login;
  String? password;

  // Actions
  onCreateAccount() {

  }

  onLogin() {
    print({login, password});
  }
}
