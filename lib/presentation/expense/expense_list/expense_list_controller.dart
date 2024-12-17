import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_view.dart';

class ExpenseListController with ChangeNotifier {
  ExpenseListController(this._context);

  // Dependencies
  late final expenseUseCase = _context.dependencyManager.expenseUseCase;
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
    var refresh = await _context.pushScreen(ExpenseFormView(expense: expense));

    await _doRefresh(refresh);
  }

  onAdd() async {
    var refresh = await _context.pushScreen(const ExpenseFormView());
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
