import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';

import '../../domain/use_case/user_use_case.dart';
import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  final _settingsService = Modular.get<SettingsService>();
  final userUseCase = Modular.get<UserUseCase>();

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    var (_, error) = await userUseCase.getUser();
    if (error is Empty) {
      Modular.setInitialRoute(DashboardView.routeName);
    }
  }

  logout(BuildContext context) async {
    var (_, err) = await userUseCase.logOut();
    if (err is Failure) {
      showSnackbar(context: context, text: err.message);
    } else if (err is Empty) {
      Modular.to.navigate(LoginView.routeName);
    }
  }

  updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }
}
