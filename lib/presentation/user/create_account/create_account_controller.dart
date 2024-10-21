import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

class CreateAccountController with ChangeNotifier {
  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();

  // State
  String email = "";
  String emailError = "";
  String password = "";
  String passwordError = "";
  String name = "";
  String nameError = "";
  double balance = 0;
  String balanceError = "";

  // Actions
  onClickCreateAccount() async {
    var (_, error) = await userUseCase.insert(User(
      password: password,
      balance: balance,
      email: email,
      name: name,
    ));

    switch (error) {
      case Empty():
        print("Usuário criado com sucesso.");
        break;

      case Failure(:final message):
        print("Erro: $message");
        break;

      case FieldFailure(:final fieldErrorList):
        print("Erro de validação nos seguintes campos:");
        for (var invalidField in fieldErrorList) {
          switch (invalidField.field) {
            case "name":
              nameError = invalidField.message;
              break;
            case "email":
              emailError = invalidField.message;
              break;
            case "password":
              passwordError = invalidField.message;
              break;
            case "balance":
              balanceError = invalidField.message;
              break;
          }
        }
        break;

      default:
        print("Erro desconhecido.");
    }
  }

  onClickBack() async {
    Modular.to.pop();
  }
}
