import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/create_account/create_account_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class LoginController with ChangeNotifier {
  LoginController(this._context);

  // Dependencies
  late final userUseCase = _context.dependencyManager.userUseCase;
  final BuildContext _context;

  // State
  String email = "";
  String password = "";
  bool loading = false;

  // Actions
  onClickCreateAccount() async {
    _context.pushScreen(const CreateAccountView());
  }

  onLogin() async {
    if (loading == true) return;

    loading = true;
    notifyListeners();

    var result = await userUseCase.login(email, password);

    result.onSuccess((success) {
      _context.pushScreen(const DashboardView());
      loading = false;
      notifyListeners();
    });

    result.onFailure((error) {
      showSnackbar(context: _context, text: error.toString());
      loading = false;
      notifyListeners();
    });
  }
}
