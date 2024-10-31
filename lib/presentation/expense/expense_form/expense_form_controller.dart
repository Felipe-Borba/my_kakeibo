import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';

class ExpenseFormController with ChangeNotifier {
  // Dependencies
  final expenseUseCase = Modular.get<ExpenseUseCase>();

  // State
  final formKey = GlobalKey<FormState>();
  double? amount;
  ExpenseCategory? category;
  DateTime? selectedDate;
  String? description;

  Expense? expense;

  // Actions
  loadInitialData(Expense? expense) async {
    this.expense = expense;
    if (expense != null) {
      amount = expense.amount;
      category = expense.category;
      selectedDate = expense.date;
      description = expense.description;
    }
    notifyListeners();
  }

  setAmount(String amount) {
    this.amount = double.tryParse(amount);
    notifyListeners();
  }

  setCategory(ExpenseCategory? newValue) {
    category = newValue;
    notifyListeners();
  }

  setSelectDate(DateTime? selectedDate) {
    this.selectedDate = selectedDate;
    notifyListeners();
  }

  setDescription(String? description) {
    this.description = description;
    notifyListeners();
  }

  onClickSave(BuildContext context) async {
    //TODO talvez exista uma forma melhor de validar a entidade principalmente quando se trata de campos de tipos diferentes de string?
    // Vi que na comunidade a galera usa o componente textFormFiel ai a validação fica no input mas a regra pode deixar em outro lugar
    bool isvalid = formKey.currentState?.validate() ?? false;
    if (isvalid) return;

    // var (_, error) = await expenseUseCase.insert(Expense(
    //   id: expense?.id,
    //   amount: amount!,
    //   category: category ?? ExpenseCategory.misc,
    //   description: description.text,
    //   date: selectedDate ?? DateTime.now(),
    // ));
    //
    // switch (error) {
    //   case Empty():
    //     Modular.to.pop(true);
    //     break;
    //   case Failure(:final message):
    //     showSnackbar(context: context, text: message);
    //     break;
    //   default:
    //     showSnackbar(context: context, text: "Erro desconhecido.");
    // }
    // notifyListeners();
  }
}
