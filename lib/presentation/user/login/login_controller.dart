import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

    if (error is Failure) {
      Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    notifyListeners();
  }
}
