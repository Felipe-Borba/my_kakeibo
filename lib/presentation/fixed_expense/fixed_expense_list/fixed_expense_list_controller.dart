import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/use_case/fixed_expense_use_case.dart';
import 'package:my_kakeibo/presentation/fixed_expense/fixed_expense_form/fixed_expense_form_view.dart';

class FixedExpenseListController with ChangeNotifier {
  FixedExpenseListController(this._context);

  // Dependencies
  final fixedExpenseUseCase = Modular.get<FixedExpenseUseCase>();
  final BuildContext _context;

  // State
  List<FixedExpense> list = List.empty();
  int sortNumber = 1;

  // Actions
  getInitialData() async {
    var (expenseList, error) = await fixedExpenseUseCase.findAll();
    if (error is Failure) {
      showSnackbar(context: _context, text: error.message);
    }
    list = expenseList;
    sortByNumber(sortNumber);
  }

  setSortBy(int sortNumber) {
    this.sortNumber = sortNumber;
    sortByNumber(sortNumber);
    notifyListeners();
  }

  void sortByNumber(int sortNumber) {
    switch (sortNumber) {
      case 1:
        list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case 2:
        list.sort((a, b) => b.dueDate.compareTo(a.dueDate));
      default:
    }
  }

  onDelete(FixedExpense fixedExpense) async {
    await fixedExpenseUseCase.delete(fixedExpense);
    _doRefresh(true);
  }

  onEdit(FixedExpense fixedExpense) async {
    var refresh = await Modular.to.pushNamed<bool>(
      FixedExpenseFormView.routeName,
      arguments: fixedExpense,
    );

    await _doRefresh(refresh);
  }

  onAdd() async {
    var refresh =
        await Modular.to.pushNamed<bool>(FixedExpenseFormView.routeName);
    await _doRefresh(refresh);
  }

  _doRefresh(bool? refresh) async {
    if (refresh == true) {
      var (list, error) = await fixedExpenseUseCase.findAll();
      this.list = list;
      list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      notifyListeners();
    }
  }

  pay(FixedExpense fixedExpense) async {
    var (res, error) = await fixedExpenseUseCase.pay(fixedExpense);
    if (error is Failure) {
      showSnackbar(context: _context, text: error.message);
    } else {
      _doRefresh(true);
    }
  }
}
