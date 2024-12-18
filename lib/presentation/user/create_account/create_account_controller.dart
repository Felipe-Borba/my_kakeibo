import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class CreateAccountController with ChangeNotifier {
  CreateAccountController(this._context);

  // Dependencies
  final formKey = GlobalKey<FormState>();
  final userUseCase = Modular.get<UserUseCase>();
  final BuildContext _context;

  // State
  String? email;
  String? password;
  String? passwordConfirm;
  String? name;

  // Actions
  onClickCreateAccount() async {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var (_, error) = await userUseCase.insert(User(
      password: password!,
      email: email!,
      name: name!,
    ));

    switch (error) {
      case Empty():
        Modular.to.navigate(DashboardView.routeName);
        break;
      case Failure(:final message):
        showSnackbar(context: _context, text: message);
        break;
      default:
        showSnackbar(context: _context, text: "Erro desconhecido.");
    }
    notifyListeners();
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
    if (value.isEmpty) return "Field is required";
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
