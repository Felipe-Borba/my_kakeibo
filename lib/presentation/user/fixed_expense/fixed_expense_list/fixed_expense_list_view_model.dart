import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_form/fixed_expense_form_view.dart';

class FixedExpenseListViewModel with ChangeNotifier {
  FixedExpenseListViewModel(this._context) {
    getInitialData();
  }

  // Dependencies
  late final fixedExpenseUseCase =
      _context.dependencyManager.fixedExpenseUseCase;
  final BuildContext _context;

  // State
  List<FixedExpense> list = List.empty();
  int sortNumber = 1;

  // Actions
  getInitialData() async {
    var result = await fixedExpenseUseCase.findAll();
    result.onSuccess((success) {
      list = success;
      sortByNumber(sortNumber);
      notifyListeners();
    });

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
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
    var refresh = await _context.pushScreen(FixedExpenseFormView(
      fixedExpense: fixedExpense,
    ));

    await _doRefresh(refresh);
  }

  onAdd() async {
    var refresh = await _context.pushScreen(const FixedExpenseFormView());
    await _doRefresh(refresh);
  }

  _doRefresh(bool? refresh) async {
    if (refresh == true) {
      var result = await fixedExpenseUseCase.findAll();
      result.onSuccess((success) {
        list = success;
        list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        notifyListeners();
      });
    }
  }

  pay(FixedExpense fixedExpense) async {
    var result = await fixedExpenseUseCase.pay(fixedExpense);
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      _doRefresh(true);
    });
  }
}
