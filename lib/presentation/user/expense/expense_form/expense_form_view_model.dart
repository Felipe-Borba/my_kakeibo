import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';

class ExpenseFormViewModel with ChangeNotifier {
  ExpenseFormViewModel(this._context, this._expense, this._expenseRepository);

  // Dependencies
  final BuildContext _context;
  final Expense? _expense;
  final ExpenseRepository _expenseRepository;

  // State
  final formKey = GlobalKey<FormState>();

  // late final currencyFormatter = CurrencyFormatter(_context).formatter;

  late double? amount = _expense?.amount;
  late DateTime? date = _expense?.date;
  late String description = _expense?.description ?? '';
  late ExpenseCategory? category = _expense?.category;

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

  void setDate(DateTime? value) {
    date = value;
  }

  String? validateDate(String? value) {
    final dateFormat = DateFormat.yMEd(_context.locale.toString());
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

    var result = await _expenseRepository.insert(Expense(
      id: _expense?.id,
      amount: amount!,
      date: date ?? DateTime.now(),
      description: description,
      category: category!,
    ));

    result.onFailure((error) {
      showSnackbar(context: _context, text: error.toString());
    });

    result.onSuccess((success) {
      _context.popScreen(true);
    });

    notifyListeners();
  }
}
