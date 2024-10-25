import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

class CreateAccountController with ChangeNotifier {
  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();

  // State
  TextEditingController email = TextEditingController();
  String? emailError;
  TextEditingController password = TextEditingController();
  String? passwordError;
  TextEditingController name = TextEditingController();
  String? nameError;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }

  // Actions
  onClickCreateAccount() async {
    var (_, error) = await userUseCase.insert(User(
      password: password.text,
      email: email.text,
      name: name.text,
    ));

    nameError = null;
    emailError = null;
    passwordError = null;

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
          }
        }
        break;
      default:
        print("Erro desconhecido.");
    }
    notifyListeners();
  }
}
