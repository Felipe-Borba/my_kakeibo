import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_kakeibo/core/theme.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_view.dart';

import 'presentation/settings/settings_controller.dart';
import 'presentation/settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
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
          initialRoute: WelcomeView.routeName,
          routes: {
            SettingsView.routeName: (_) =>
                SettingsView(controller: settingsController),
            WelcomeView.routeName: (_) => const WelcomeView(),
          },
        );
      },
    );
  }
}
