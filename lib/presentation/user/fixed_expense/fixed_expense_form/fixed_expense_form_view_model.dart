import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_form/fixed_expense_validator.dart';

class FixedExpenseFormViewModel with ChangeNotifier {
  FixedExpenseFormViewModel(
    this._context,
    this._fixedExpense,
    this._fixedExpenseRepository,
  );

  // Dependencies
  final BuildContext _context;
  final FixedExpense? _fixedExpense;
  final FixedExpenseRepository _fixedExpenseRepository;
  late final validator = FixedExpenseValidator(context: _context);

  // State
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late String? id = _fixedExpense?.id;
  late List<Expense> expenseList = _fixedExpense?.expenseList ?? [];
  late double? amount = _fixedExpense?.amount;
  late DateTime? dueDate = _fixedExpense?.dueDate;
  late String description = _fixedExpense?.description ?? '';
  late ExpenseCategory? category = _fixedExpense?.category;
  late Frequency? frequency = _fixedExpense?.frequency;
  late Remember? remember = _fixedExpense?.remember ?? Remember.no;

  // Actions
  void onClickSave() async {
    if (validator.isInvalid()) return;

    _isLoading = true;
    notifyListeners();

    var result = await _fixedExpenseRepository.insert(
      id: id,
      description: description,
      category: category!,
      dueDate: dueDate,
      amount: amount!,
      expenseList: expenseList,
      frequency: frequency!,
      remember: remember!,
      notificationTitle: _context.intl.fixedExpenseNotificationTitle,
    );

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    result.onSuccess((success) {
      _context.popScreen(true);
    });

    _isLoading = false;
    notifyListeners();
  }
}
