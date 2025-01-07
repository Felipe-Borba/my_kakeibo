import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/presentation/onboarding/hello/hello_view.dart';

class UserInfoController with ChangeNotifier {
  final BuildContext _context;
  late final _userUseCase = _context.dependencyManager.userUseCase;

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
    var result = await _userUseCase.getUser();
    var user = result.getOrDefault(User.createOnboardingUser(name!));
    var saveResult = await _userUseCase.save(user);

    saveResult.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    saveResult.onSuccess((success) {
      _context.pushAndRemoveAllScreen(HelloView(name: name!));
    });
  }
}
