import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/login/login_view.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._context);

  final BuildContext _context;
  late final userUseCase = _context.dependencyManager.userUseCase;

  UserTheme userTheme = UserTheme.system;
  Widget initialRoute = const WelcomeView();

  loadSettings() async {
    var result = await userUseCase.getUser();
    result.onSuccess((user) {
      initialRoute = const DashboardView();
    });
  }

  //depois que o usuário configurar o backup na nuvem não tem como desativar só se deletar os dados
  logout() async {
    var result = await userUseCase.logOut();
    result.onFailure((err) {
      showSnackbar(context: _context, text: err.toString());
    });
    result.onSuccess((success) {
      _context.pushScreen(const LoginView());
    });
  }

  updateThemeMode(UserTheme? newThemeMode) async {
    if (newThemeMode == null) return;
    userTheme = newThemeMode;
    notifyListeners();
  }

  deleteData() async {
    var result = await userUseCase.deleteData();
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      Navigator.of(_context).pop(true);
    });
  }
}
