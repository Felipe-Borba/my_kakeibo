import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_form_view.dart';

class ExpenseListViewModel with ChangeNotifier {
  ExpenseListViewModel(this._context) {
    getInitialData();
  }

  // Dependencies
  late final expenseUseCase = _context.dependencyManager.expenseUseCase;
  final BuildContext _context;

  // State
  List<Expense> list = List.empty();
  int sortNumber = 2;
  DateTime monthFilter = DateTime.now();

  // Actions
  getInitialData() async {
    var result = await expenseUseCase.findByMonth(
      month: monthFilter,
    );
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      list = success;
      sortByNumber(sortNumber);
    });

    notifyListeners();
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
      var result = await expenseUseCase.findAll();
      result.onSuccess((success) {
        list = success;
        list.sort((a, b) => a.date.compareTo(b.date));
        notifyListeners();
      });
    }
  }

  setMonthFilter(DateTime value) {
    monthFilter = value;
    getInitialData();
    notifyListeners();
  }
}
