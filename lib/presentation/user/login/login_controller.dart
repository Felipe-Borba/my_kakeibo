import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

class LoginController with ChangeNotifier {
  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();

  // State
  String email = "";
  String password = "";

  // Actions
  onClickCreateAccount() async {
    // Modular.to.navigate(CreateAccount.routeName);
  }

  onLogin() async {
    var (user, error) = await userUseCase.login(email, password);

    switch (error) {
      case Empty():
        print("Usuário logado com sucesso.");
        break;

      case Failure(:final message):
        print("Erro: $message");
        break;

      default:
        print("Erro desconhecido.");
    }
  }
}
