import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class CreateAccountController with ChangeNotifier {
  CreateAccountController(this._context);

  // Dependencies
  final BuildContext _context;
  final formKey = GlobalKey<FormState>();
  late final userUseCase = _context.dependencyManager.userUseCase;

  // State
  String? email;
  String? password;
  String? passwordConfirm;
  String? name;

  // Actions
  onClickCreateAccount() async {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var result = await userUseCase.insert(User(
      password: password!,
      email: email!,
      name: name!,
    ));

    result.onFailure((error) {
      showSnackbar(context: _context, text: error.toString());
    });

    result.onSuccess((success) {
      _context.pushScreen(const DashboardView());
      notifyListeners();
    });
  }

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void setName(String value) {
    name = value;
  }

  String? validateEmail(String? value) {
    if (value == null) return "Field is required";
    if (value.isEmpty) return "Field is required";
    return null;
  }

  String? validateName(String? value) {
    if (value == null) return "Field is required";
    if (value.isEmpty) return "Field is required";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null) return "Field is required";
    if (value.isEmpty) return _context.intl.fieldRequired;
    return null;
  }

  void setPasswordConfirm(String value) {
    passwordConfirm = value;
  }

  String? validatePasswordConfirm(String? value) {
    if (value == null) return "Field is required";
    if (value.isEmpty) return "Field is required";
    if (password != value) return "Senha não confere";
    return null;
  }
}
