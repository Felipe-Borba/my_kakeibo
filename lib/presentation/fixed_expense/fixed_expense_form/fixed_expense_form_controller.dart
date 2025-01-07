import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/extensions/currency.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';

class FixedExpenseFormController with ChangeNotifier {
  FixedExpenseFormController(this._context, this._fixedExpense);

  // Dependencies
  final BuildContext _context;
  final FixedExpense? _fixedExpense;
  late final fixedExpenseUseCase =
      _context.dependencyManager.fixedExpenseUseCase;

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
    if (value == null) return "valor obrigatório";
    double? amount = _context.currency.tryParse(value)?.toDouble();
    if (amount == null) return "valor obrigatório";
    if (amount <= 0) return "valor deve ser maior que zero";
    return null;
  }

  void setCategory(ExpenseCategory? value) {
    category = value;
  }

  String? validateCategory(ExpenseCategory? value) {
    if (value == null) return "Select a category";
    return null;
  }

  void setDueDate(DateTime? value) {
    dueDate = value;
  }

  String? validateDueDate(String? value) {
    if (value == null) return "Select a date";
    if (value.isEmpty) return "Select a date";
    return null;
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

    var result = await fixedExpenseUseCase.insert(FixedExpense(
      id: _fixedExpense?.id,
      description: description,
      category: category!,
      dueDate: dueDate!,
      amount: amount!,
      expenseIdList: _fixedExpense?.expenseIdList ?? [],
      frequency: frequency!,
      remember: Remember.no, //TODO implement local notifications
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
    if (value == null) return "Selecione uma opção";
    return null;
  }
}
