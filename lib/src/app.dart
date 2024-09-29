import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_kakeibo/src/core/theme.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

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
          initialRoute: SampleItemListView.routeName,
          routes: {
            SettingsView.routeName: (_) =>
                SettingsView(controller: settingsController),
            SampleItemListView.routeName: (_) => const SampleItemListView(),
            SampleItemDetailsView.routeName: (_) =>
                const SampleItemDetailsView(),
          },
        );
      },
    );
  }
}
