import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';

class ExpenseFormController with ChangeNotifier {
  // Dependencies
  final expenseUseCase = Modular.get<ExpenseUseCase>();

  // State
  TextEditingController amount = TextEditingController();
  String? amountError;

  ExpenseCategory? category;
  String? categoryError;

  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();
  String? dateError;

  TextEditingController description = TextEditingController();
  String? descriptionError;

  Expense? expense;

  // Actions
  loadInitialData(Expense? expense) async {
    this.expense = expense;
    if (expense != null) {
      amount.text = expense.amount.toString();
      category = expense.category;
      selectedDate = expense.date;
      dateController.text = "${expense.date.toLocal()}".split(' ')[0];
      description.text = expense.description;
    }
  }

  onSelectCategory(ExpenseCategory? newValue) {
    category = newValue;
    notifyListeners();
  }

  onSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = "${selectedDate!.toLocal()}".split(' ')[0];
    }
    notifyListeners();
  }

  onClickSave(BuildContext context) async {
    //TODO talvez exista uma forma melhor de validar a entidade principalmente quando se trata de campos de tipos diferentes de string?
    var (_, error) = await expenseUseCase.insert(Expense(
      id: expense?.id,
      amount: double.parse(amount.text),
      category: category ?? ExpenseCategory.misc,
      description: description.text,
      date: selectedDate ?? DateTime.now(),
    ));

    amountError = null;

    switch (error) {
      case Empty():
        Modular.to.pop(true);
        break;
      case Failure(:final message):
        showSnackbar(context: context, text: message);
        break;
      case FieldFailure(:final fieldErrorList):
        for (var invalidField in fieldErrorList) {
          switch (invalidField.name) {
            case "amount":
              amountError = invalidField.message;
              break;
          }
        }
        break;
      default:
        showSnackbar(context: context, text: "Erro desconhecido.");
    }
    notifyListeners();
  }
}
