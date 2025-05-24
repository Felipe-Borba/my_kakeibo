import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/user/user_language.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/mappers/user_language_mapper.dart';
import 'package:my_kakeibo/presentation/core/mappers/user_theme_mapper.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';
import 'package:my_kakeibo/presentation/settings/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  final SettingsViewModel viewModel;

  const SettingsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBar: AppBarCustom(title: context.intl.settings),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
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
            const SizedBox(height: 16),
            DropdownButton<UserLanguage>(
              value: viewModel.userLanguage,
              onChanged: viewModel.updateLanguage,
              items: UserLanguage.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.getTranslation(context)),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              key: WidgetKeys.deleteData,
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
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
