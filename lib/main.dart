import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/firebase_options.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_controller.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_controller.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_view.dart';

import 'app.dart';
import 'presentation/settings/settings_controller.dart';
import 'presentation/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
    r.redirect("/", to: WelcomeView.routeName);
    r.child(SettingsView.routeName, child: (context) => const SettingsView());
    r.child(LoginView.routeName, child: (context) => const LoginView());
    r.child(WelcomeView.routeName, child: (context) => const WelcomeView());
  }
}
