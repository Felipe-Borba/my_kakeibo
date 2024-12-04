import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/presentation/onboarding/hello/hello_view.dart';

class UserInfoController with ChangeNotifier {
  final _userUseCase = Modular.get<UserUseCase>();
  final BuildContext _context;

  UserInfoController(this._context);

  // State
  final formKey = GlobalKey<FormState>();
  String? name;

  // Actions
  String? validateName(String? value) {
    if (value == null) return _context.intl.fieldRequired;
    if (value.isEmpty) return _context.intl.fieldRequired;
    return null;
  }

  void onSubmit() async {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    //essas 3 linhas acho que deveria ser um único caso de uso createOnboardingUser
    var (user, userError) = await _userUseCase.getUser();
    user ??= User.createOnboardingUser(name!);
    var (newUser, newUserError) = await _userUseCase.save(user);

    if (newUserError is Failure) {
      showSnackbar(context: _context, text: newUserError.message);
      return;
    }

    Modular.to.navigate(HelloView.routeName, arguments: name);
  }
}
