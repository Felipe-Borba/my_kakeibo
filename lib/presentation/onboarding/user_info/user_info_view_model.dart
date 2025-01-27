import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/onboarding/hello/hello_view.dart';

class UserInfoViewModel with ChangeNotifier {
  final BuildContext _context;
  late final _userUseCase = _context.dependencyManager.userUseCase;
  late final _expenseCategoryRepository =
      _context.dependencyManager.expenseCategoryRealmRepository;

  UserInfoViewModel(this._context);

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

    //TODO essas 3 linhas acho que deveria ser um único caso de uso createOnboardingUser
    var expenseCategories = [
      ExpenseCategory(
        name: _context.intl.misc,
        icon: IconCustom.misc,
        color: ColorCustom.blue,
      ),
      ExpenseCategory(
        name: _context.intl.book,
        icon: IconCustom.book,
        color: ColorCustom.brown,
      ),
      ExpenseCategory(
        name: _context.intl.doctor,
        icon: IconCustom.doctor,
        color: ColorCustom.orange,
      ),
      ExpenseCategory(
        name: _context.intl.dog,
        icon: IconCustom.dog,
        color: ColorCustom.purple,
      ),
      ExpenseCategory(
        name: _context.intl.food,
        icon: IconCustom.food,
        color: ColorCustom.yellow,
      ),
    ];
    for (var element in expenseCategories) {
      _expenseCategoryRepository.insert(element);
    }
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
