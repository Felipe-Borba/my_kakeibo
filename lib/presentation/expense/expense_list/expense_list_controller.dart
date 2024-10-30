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
  int sortNumber = 1;

  // Actions
  getInitialData(BuildContext context) async {
    var (expenseList, error) = await expenseUseCase.findAll();
    if (error is Failure) {
      showSnackbar(context: context, text: error.message);
    }
    list = expenseList;
    list.sort((a, b) => a.date.compareTo(b.date));
  }

  sortBy(int sortNumber) {
    this.sortNumber = sortNumber;
    switch (sortNumber) {
      case 1:
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 2:
        list.sort((a, b) => b.date.compareTo(a.date));
      default:
    }
    notifyListeners();
  }

  onDelete(Expense expense) async {
    await expenseUseCase.delete(expense);
    _doRefresh(true);
  }

  onEdit(Expense expense) async {
    var refresh = await Modular.to.pushNamed<bool>(
      ExpenseFormView.routeName,
      arguments: expense,
    );

    await _doRefresh(refresh);
  }

  onAdd() async {
    var refresh = await Modular.to.pushNamed<bool>(ExpenseFormView.routeName);
    await _doRefresh(refresh);
  }

  _doRefresh(bool? refresh) async {
    if (refresh == true) {
      var (list, error) = await expenseUseCase.findAll();
      this.list = list;
      list.sort((a, b) => a.date.compareTo(b.date));
      notifyListeners();
    }
  }
}
