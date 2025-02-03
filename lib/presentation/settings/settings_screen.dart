import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(context, context.read()),
      builder: (context, child) {
        final viewModel = Provider.of<SettingsViewModel>(context);
        return SettingsView(viewModel: viewModel);
      },
    );
  }
}
