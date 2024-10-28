import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

class AddExpenseController with ChangeNotifier {
  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();

  // State

  // Actions
  onClickCreateAccount() async {
    //TODO
  }
}
