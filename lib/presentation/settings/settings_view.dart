import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/user/user_language.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(
            context,
            context.intl.apperance,
            Icons.palette,
          ),
          _section(
            context.intl.theme,
            DropdownButtonFormField<UserTheme>(
              value: viewModel.userTheme,
              onChanged: viewModel.updateThemeMode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              items: UserTheme.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: TextCustom(
                        e.getTranslation(context),
                        theme: CustomTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle(
            context,
            context.intl.language,
            Icons.language,
          ),
          _section(
            context.intl.select_language,
            DropdownButtonFormField<UserLanguage>(
              value: viewModel.userLanguage,
              onChanged: viewModel.updateLanguage,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              items: UserLanguage.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: TextCustom(
                        e.getTranslation(context),
                        theme: CustomTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle(
            context,
            context.intl.data_management,
            Icons.storage,
          ),
          _section(
            context.intl.this_action_will_permanently_delete_all_your_data,
            ElevatedButton.icon(
              key: WidgetKeys.deleteData,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: TextCustom(
                        context.intl.confirmDeleteData,
                        theme: CustomTheme.titleLarge,
                      ),
                      content: TextCustom(
                        context.intl.confirmDeleteDataText,
                        theme: CustomTheme.bodyMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: TextCustom(
                            context.intl.cancel,
                            theme: CustomTheme.labelLarge,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await viewModel.deleteData();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: TextCustom(
                                    context.intl.data_deleted_successfully,
                                    theme: CustomTheme.bodyMedium,
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          style: const ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(Colors.red),
                          ),
                          child: TextCustom(
                            context.intl.delete,
                            theme: CustomTheme.labelLarge,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              label: Text(context.intl.deleteData),
              icon: const Icon(Icons.warning_amber_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String label, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(label, theme: CustomTheme.titleMedium),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          TextCustom(
            title,
            theme: CustomTheme.titleLarge,
            prominent: true,
          ),
        ],
      ),
    );
  }
}
