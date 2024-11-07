import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/formatter/currency_formatter.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';

class ExpenseFormController with ChangeNotifier {
  ExpenseFormController(this._context, this._expense);

  // Dependencies
  final BuildContext _context;
  final Expense? _expense;
  final expenseUseCase = Modular.get<ExpenseUseCase>();

  // State
  final formKey = GlobalKey<FormState>();
  late final currencyFormatter = CurrencyFormatter(_context).formatter;

  late double? amount = _expense?.amount;
  late DateTime? date = _expense?.date;
  late String description = _expense?.description ?? '';
  late ExpenseCategory? category = _expense?.category;

  // Actions
  void setAmount(double? value) {
    amount = value;
  }

  String? validateAmount(String? value) {
    //TODO agora sim a partir desse momento eu posso pensar na lib do lucid_validation, a unica coisa que eu acho que ganharia seria mandar as validações para a camada de dominio e internacionalização out of the box, mas em contrapartida eu ganho duas camadas acopladas a uma lib...
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

  void setDate(DateTime? value) {
    date = value;
  }

  String? validateDate(String? value) {
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

    var (_, error) = await expenseUseCase.insert(Expense(
      id: _expense?.id,
      amount: amount!,
      date: date!,
      description: description,
      category: category!,
    ));

    if (error is Empty) {
      Modular.to.pop(true);
    } else if (error is Failure) {
      showSnackbar(context: _context, text: error.message);
    }

    notifyListeners();
  }
}
