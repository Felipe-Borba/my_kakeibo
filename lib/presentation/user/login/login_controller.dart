import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/presentation/user/create_account/create_account_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class LoginController with ChangeNotifier {
  LoginController(this._context); 

  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();
  final BuildContext _context;

  // State
  String email = "";
  String password = "";
  bool loading = false;

  // Actions
  onClickCreateAccount() async {
    Modular.to.pushNamed(CreateAccountView.routeName);
  }

  onLogin() async {
    if (loading == true) return;

    loading = true;
    notifyListeners();

    var (user, error) = await userUseCase.login(email, password);

    if (error is Failure) {
      showSnackbar(context: _context, text: error.message);
    } else {
      Modular.to.navigate(DashboardView.routeName);
    }

    loading = false;
    notifyListeners();
  }
}
