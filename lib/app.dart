import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/user_theme_extension.dart';
import 'package:my_kakeibo/presentation/core/app_theme.dart';
import 'package:provider/provider.dart';

import 'presentation/settings/settings_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final theme = getMaterialTheme(context);

    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(context),
      builder: (context, child) {
        final settingsController = Provider.of<SettingsViewModel>(context);

        return FutureBuilder(
          future: settingsController.loadSettings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return MaterialApp(
              restorationScopeId: 'myKakeibo',
              debugShowCheckedModeBanner: false,
              //
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // locale: const Locale("pt"),
              supportedLocales: const [
                Locale('en'),
                Locale('pt'),
              ],
              //
              onGenerateTitle: (context) => context.intl.appTitle,
              //
              themeMode: settingsController.userTheme.toThemeMode(),
              theme: theme.light(),
              darkTheme: theme.dark(),
              highContrastTheme: theme.lightHighContrast(),
              highContrastDarkTheme: theme.darkHighContrast(),
              //
              home: settingsController.initialRoute,
            );
          },
        );
      },
    );
  }
}
