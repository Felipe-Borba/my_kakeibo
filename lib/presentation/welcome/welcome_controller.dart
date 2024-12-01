import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';

class WelcomeController with ChangeNotifier {
  // Dependencies

  // State

  // Actions
  void onContinue() {
    Modular.to.navigate(LoginView.routeName);
  }
}
