import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';

// acho qur vou ficar com esse modelo porque é o mais aceito pela comunidade, simples,
class WelcomeController with ChangeNotifier {
  // Dependencies

  // State

  // Actions
  void onContinue() {
    Modular.to.navigate(LoginView.routeName);
  }
}
