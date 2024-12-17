import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._context);

  final BuildContext _context;
  late final userUseCase = _context.dependencyManager.userUseCase;

  UserTheme userTheme = UserTheme.system;
  Widget initialRoute = const WelcomeView();

  loadSettings() async {
    var (user, error) = await userUseCase.getUser();
    if (error is Empty) {
      initialRoute =  const DashboardView();
    }
  }

  //depois que o usuário configurar o backup na nuvem não tem como desativar só se deletar os dados
  logout() async {
    var (_, err) = await userUseCase.logOut();
    if (err is Failure) {
      showSnackbar(context: _context, text: err.message);
    } else if (err is Empty) {
      _context.pushScreen(const LoginView());
    }
  }

  updateThemeMode(UserTheme? newThemeMode) async {
    if (newThemeMode == null) return;
    userTheme = newThemeMode;
    notifyListeners();
  }

  deleteData() async {
    var (res, error) = await userUseCase.deleteData();
    if (error is Failure) {
      showSnackbar(context: _context, text: error.message);
    }
  }
}
