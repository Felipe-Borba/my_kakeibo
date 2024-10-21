import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/user/login/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LoginController>();

    return const Scaffold(
      body: Placeholder(),
    );
  }
}
