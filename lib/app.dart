import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/theme.dart';
import 'package:my_kakeibo/core/util.dart';
import 'package:provider/provider.dart';

import 'presentation/settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context) //
        .platformDispatcher
        .platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Alice", "Anek Bangla");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ChangeNotifierProvider(
      create: (context) => SettingsController(context),
      builder: (context, child) {
        final settingsController = Provider.of<SettingsController>(context);

        return FutureBuilder(
          future: settingsController.loadSettings(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(child: CircularProgressIndicator());
            // }

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
              locale: const Locale("pt"),
              supportedLocales: const [
                Locale('en'),
                Locale('pt'),
              ],
              //
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,
              //
              darkTheme: theme.dark(),
              theme: brightness == Brightness.light //
                  ? theme.light()
                  : theme.dark(),
              themeMode: settingsController.themeMode,
              //
              routerConfig: Modular.routerConfig,
            );
          },
        );
      },
    );
  }
}
