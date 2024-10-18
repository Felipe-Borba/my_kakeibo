import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/login/login_controller.dart';
import 'package:my_kakeibo/presentation/login/login_view.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_controller.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_view.dart';

import 'app.dart';
import 'presentation/settings/settings_controller.dart';
import 'presentation/settings/settings_service.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(SettingsService.new);
    i.addSingleton(SettingsController.new);

    i.add(LoginController.new);
    i.add(WelcomeController.new);
  }

  @override
  void routes(r) {
    r.child(SettingsView.routeName, child: (context) => const SettingsView());
    r.child(LoginView.routeName, child: (context) => const LoginView());
    r.child(WelcomeView.routeName, child: (context) => const WelcomeView());
  }
}
