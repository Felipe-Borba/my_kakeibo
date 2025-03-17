import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';

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

  // State
  final formKey = GlobalKey<FormState>();

  late double? amount = _fixedExpense?.amount;
  late DateTime? dueDate = _fixedExpense?.dueDate;
  late String description = _fixedExpense?.description ?? '';
  late ExpenseCategory? category = _fixedExpense?.category;
  late Frequency? frequency = _fixedExpense?.frequency;

  // Actions
  void setAmount(double? value) {
    amount = value;
  }

  String? validateAmount(String? value) {
    if (value == null) return _context.intl.fieldRequired;
    double? amount = _context.currency.tryParse(value)?.toDouble();
    if (amount == null) return _context.intl.fieldRequired;
    if (amount <= 0) return _context.intl.fieldGreaterThenZero;
    return null;
  }

  void setCategory(ExpenseCategory? value) {
    category = value;
  }

  String? validateCategory(ExpenseCategory? value) {
    if (value == null) return _context.intl.fieldRequired;
    return null;
  }

  void setDueDate(DateTime? value) {
    dueDate = value;
  }

  String? validateDueDate(String? value) {
    //TODO isso tá repetido lá na expense_form_view_model e qdo for add em um novo lugar é chato de importar isso por causa do intl
    final dateFormat = DateFormat.yMEd(
      Localizations.localeOf(_context).toString(),
    );
    final date = dateFormat.tryParse(value ?? '');
    if (date is DateTime) return null;
    return _context.intl.fieldRequired;
  }

  void setDescription(String value) {
    description = value;
  }

  String? validateDescription(String? value) {
    return null;
  }

  void onClickSave() async {
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var result = await _fixedExpenseRepository.insert(FixedExpense(
      id: _fixedExpense?.id,
      description: description,
      category: category!,
      dueDate: dueDate ?? DateTime.now(),
      amount: amount!,
      expenseList: _fixedExpense?.expenseList ?? [],
      frequency: frequency!,
      remember: Remember.no,
    ));

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });

    result.onSuccess((success) {
      _context.popScreen(true);
    });

    notifyListeners();
  }

  String? validateFrequency(Frequency? value) {
    if (value == null) return _context.intl.fieldRequired;
    return null;
  }
}
