import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/repository/expense_category_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';

class ExpenseCategoryFormViewModel with ChangeNotifier {
  ExpenseCategoryFormViewModel(
    this._context,
    this._expenseCategory,
    this._expenseCategoryRepository,
  );

  // Dependencies
  final BuildContext _context;
  final ExpenseCategory? _expenseCategory;
  final ExpenseCategoryRepository _expenseCategoryRepository;

  // State
  final formKey = GlobalKey<FormState>();

  late ColorCustom? color = _expenseCategory?.color;
  late IconCustom? icon = _expenseCategory?.icon;
  late String? name = _expenseCategory?.name;
  late ExpenseCategory? category = _expenseCategory;

  // Actions
  String? validateColor(ColorCustom? value) {
    if (value == null) return _context.intl.fieldRequired;
    return null;
  }

  String? validateIcon(IconCustom? value) {
    if (value == null) return _context.intl.fieldRequired;
    return null;
  }

  String? validateName(String? value) {
    if (value == null) return _context.intl.fieldRequired;
    return null;
  }

  void onClickSave() async {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var expenseCategory = ExpenseCategory(
      id: _expenseCategory?.id,
      name: name!,
      color: color!,
      icon: icon!,
    );

    final result = await _expenseCategoryRepository.save(expenseCategory);

    result.onFailure((error) {
      showSnackbar(context: _context, text: error.toString());
    });

    result.onSuccess((success) {
      _context.popScreen(true);
    });

    notifyListeners();
  }
}
