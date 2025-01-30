import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_form_view.dart';

class ExpenseListViewModel with ChangeNotifier {
  ExpenseListViewModel(this._context, this._expenseUseCase) {
    getInitialData();
  }

  // Dependencies
  final ExpenseUseCase _expenseUseCase;
  final BuildContext _context;

  // State
  List<Expense> list = List.empty();
  SortEnum sort = SortEnum.dateDesc;
  DateTime monthFilter = DateTime.now();

  // Actions
  getInitialData() async {
    var result = await _expenseUseCase.findByMonth(
      month: monthFilter,
    );
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      list = success;
      sortByNumber(sort);
    });

    notifyListeners();
  }

  setSortBy(SortEnum sort) {
    this.sort = sort;
    sortByNumber(sort);
    notifyListeners();
  }

  void sortByNumber(SortEnum sort) {
    switch (sort) {
      case SortEnum.dateAsc:
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortEnum.dateDesc:
        list.sort((a, b) => b.date.compareTo(a.date));
        break;
    }
  }

  onDelete(Expense expense) async {
    await _expenseUseCase.delete(expense);
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
      var result = await _expenseUseCase.findAll();
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
