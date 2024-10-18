import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/theme.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_view.dart';

import 'presentation/settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Modular.get<SettingsController>();
    // AppLocalizations? test = AppLocalizations.of(context);
    // print(test);

    Modular.setInitialRoute(WelcomeView.routeName);
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          //
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          //
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          //
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: settingsController.themeMode,
          //
          routerConfig: Modular.routerConfig,
        );
      },
    );
  }
}
