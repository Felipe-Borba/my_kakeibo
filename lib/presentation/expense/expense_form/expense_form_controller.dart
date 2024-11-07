import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
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
  late double? amount = _expense?.amount;
  late final dataController = TextEditingController(
    text: _getDate(),
  );
  late final descriptionController = TextEditingController(
    text: _expense?.description,
  );
  late ExpenseCategory? category = _expense?.category;
  late final currencyFormatter = CurrencyFormatter(_context).formatter;

  // Actions
  double? getAmount() {//TODO talvez tire esse getter, não parece ser uma prática mto comum no flutter
    return amount;
  }

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

  ExpenseCategory? getCategory() {//TODO talvez tire esse getter, não parece ser uma prática mto comum no flutter
    return category;
  }

  void setCategory(ExpenseCategory? newValue) {
    category = newValue;
    notifyListeners();
  }

  String? validateCategory(ExpenseCategory? value) {
    if (value == null) return "Select a category";
    return null;
  }

  String? _getDate() {
    if (_expense != null) {
      return DateFormat.yMEd(
        Localizations.localeOf(_context).toString(),
      ).format(_expense.date);
    }
    return null;
  }

  void setDate(DateTime? date) {
    if (date != null) {
      dataController.text = DateFormat.yMEd(
        Localizations.localeOf(_context).toString(),
      ).format(date);
      notifyListeners();
    }
  }

  String? validateDate(String? value) {
    if (value == null) return "Select a date";
    if (value.isEmpty) return "Select a date";
    return null;
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
      date: DateFormat.yMEd(
        Localizations.localeOf(_context).toString(),
      ).parse(dataController.text),
      description: descriptionController.text,
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
