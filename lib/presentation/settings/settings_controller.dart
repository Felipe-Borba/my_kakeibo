import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._context);

  final BuildContext _context;
  final userUseCase = Modular.get<UserUseCase>();

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  loadSettings() async {
    var (user, error) = await userUseCase.getUser();
    if (error is Empty) {
      Modular.to.navigate(DashboardView.routeName);
    }
  }

  //TODO adicionar funcionalidade de deletar os dados

  //depois que o usuário configurar o backup na nuvem não tem como desativar só se deletar os dados
  logout() async {
    var (_, err) = await userUseCase.logOut();
    if (err is Failure) {
      showSnackbar(context: _context, text: err.message);
    } else if (err is Empty) {
      Modular.to.navigate(LoginView.routeName);
    }
  }

  updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();
  }

  deleteData() async {
    await userUseCase.deleteData();
  }
}
