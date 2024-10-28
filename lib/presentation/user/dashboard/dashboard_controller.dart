import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

class DashboardController with ChangeNotifier {
  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();

  // State

  // Actions
  getInitialData() async {
    //TODO first call
    await Future.delayed(const Duration(seconds: 3));
  }

  onClickCreateAccount() async {
    //TODO
  }
}
