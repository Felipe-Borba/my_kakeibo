import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_view.dart';

class ExpenseListController with ChangeNotifier {
  // Dependencies
  final expenseUseCase = Modular.get<ExpenseUseCase>();

  // State
  List<Expense> list = List.empty();

  // Actions
  getInitialData(BuildContext context) async {
    var (expenseList, error) = await expenseUseCase.findAll();
    if (error is Failure) {
      showSnackbar(context: context, text: error.message);
    }
    list = expenseList;
    list.sort((a, b) => a.date.compareTo(b.date));
  }

  onDelete(Expense expense) async {
    await expenseUseCase.delete(expense);
  }

  onEdit(Expense expense) {
    Modular.to.pushNamed(
      ExpenseFormView.routeName,
      arguments: expense,
    );
  }

  onAdd() {
    Modular.to.pushNamed(ExpenseFormView.routeName);
  }
}
