import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/onboarding/hello/hello_view.dart';

class UserInfoViewModel with ChangeNotifier {
  final BuildContext _context;
  final UserRepository _userRepository;

  UserInfoViewModel(
    this._context,
    this._userRepository,
  );

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

    var saveResult = await _userRepository.createNewUser(
      name: name!,
      expenseCategories: _defaultExpenseCategories,
      incomeSources: _defaultIncomeSources,
    );

    saveResult.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    saveResult.onSuccess((success) {
      _context.pushAndRemoveAllScreen(HelloView(name: name!));
    });
  }

  late final _defaultExpenseCategories = [
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

  late final _defaultIncomeSources = [
    IncomeSource(
      name: _context.intl.salary,
      icon: IconCustom.salary,
      color: ColorCustom.green,
    ),
    IncomeSource(
      name: _context.intl.misc,
      icon: IconCustom.misc,
      color: ColorCustom.grey,
    ),
  ];
}
