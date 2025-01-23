import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/user_theme_extension.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/settings/settings_controller.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsController>(context);

    return ScaffoldCustom(
      appBar: AppBarCustom(title: context.intl.settings),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<UserTheme>(
              value: viewModel.userTheme,
              onChanged: viewModel.updateThemeMode,
              items: UserTheme.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.getTranslation(context)),
                    ),
                  )
                  .toList(),
            ),
            ElevatedButton.icon(
              key: const Key("deleteData"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(context.intl.confirmDeleteData),
                      content: Text(context.intl.confirmDeleteDataText),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(context.intl.cancel),
                        ),
                        TextButton(
                          onPressed: () async {
                            await viewModel.deleteData();
                          },
                          style: const ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(Colors.red),
                          ),
                          child: Text(context.intl.delete),
                        ),
                      ],
                    );
                  },
                );
              },
              label: Text(context.intl.deleteData),
              icon: const Icon(Icons.warning_amber_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
