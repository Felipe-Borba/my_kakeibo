import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/presentation/settings/settings_controller.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SettingsController>(context);
    final intl = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBarCustom(
        title: intl.settings,
      ),
      endDrawer: const DrawerCustom(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<ThemeMode>(
              value: controller.themeMode,
              onChanged: controller.updateThemeMode,
              items:  [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(intl.systemTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(intl.lightTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(intl.darkTheme),
                )
              ],
            ),
            ElevatedButton.icon(
              key: const Key("logout"),
              onPressed: controller.logout,
              label:  Text(intl.logout),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
