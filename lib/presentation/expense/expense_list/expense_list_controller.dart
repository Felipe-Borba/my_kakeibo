import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_view.dart';

class ExpenseListController with ChangeNotifier {
  ExpenseListController(this._context);

  // Dependencies
  final expenseUseCase = Modular.get<ExpenseUseCase>();
  final BuildContext _context;

  // State
  List<Expense> list = List.empty();
  int sortNumber = 1;
  DateTime monthFilter = DateTime.now();

  // Actions
  getInitialData() async {
    var (expenseList, error) = await expenseUseCase.findByMonth(
      month: monthFilter,
    );
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
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 2:
        list.sort((a, b) => b.date.compareTo(a.date));
      default:
    }
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

  setMonthFilter(DateTime value) {
    monthFilter = value;
    getInitialData();
    notifyListeners();
  }
}
