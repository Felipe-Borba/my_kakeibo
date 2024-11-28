import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/formatter/currency_formatter.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/use_case/fixed_expense_use_case.dart';

class FixedExpenseFormController with ChangeNotifier {
  FixedExpenseFormController(this._context, this._fixedExpense);

  // Dependencies
  final BuildContext _context;
  final FixedExpense? _fixedExpense;
  final fixedExpenseUseCase = Modular.get<FixedExpenseUseCase>();

  // State
  final formKey = GlobalKey<FormState>();
  late final currencyFormatter = CurrencyFormatter(_context).formatter;

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
    double? amount = currencyFormatter.tryParse(value)?.toDouble();
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

    var (_, error) = await fixedExpenseUseCase.insert(FixedExpense(
      id: _fixedExpense?.id,
      description: description,
      category: category!,
      dueDate: dueDate!,
      amount: amount!,
      expenseIdList: _fixedExpense?.expenseIdList ?? [],
      frequency: frequency!,
      remember: Remember.no, //TODO implement local notifications
    ));

    if (error is Empty) {
      Modular.to.pop(true);
    } else if (error is Failure) {
      showSnackbar(context: _context, text: error.message);
    }

    notifyListeners();
  }

  String? validateFrequency(Frequency? value) {
    if (value == null) return "Selecione uma opção";
    return null;
  }
}
