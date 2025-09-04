import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_form/fixed_expense_form_view.dart';

class FixedExpenseListViewModel with ChangeNotifier {
  FixedExpenseListViewModel(this._context, this._fixedExpenseRepository) {
    getInitialData();
  }

  // Dependencies
  final FixedExpenseRepository _fixedExpenseRepository;
  final BuildContext _context;

  // State
  List<FixedExpense> list = List.empty();
  SortEnum sort = SortEnum.dateAsc;

  // Actions
  getInitialData() async {
    var result = await _fixedExpenseRepository.findAll();
    result.onSuccess((success) {
      list = success;
      sortByNumber(sort);
      notifyListeners();
    });

    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
  }

  setSortBy(SortEnum sort) {
    this.sort = sort;
    sortByNumber(sort);
    notifyListeners();
  }

  void sortByNumber(SortEnum sort) {
    switch (sort) {
      case SortEnum.dateAsc:
        list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case SortEnum.dateDesc:
        list.sort((a, b) => b.dueDate.compareTo(a.dueDate));
        break;
    }
  }

  onDelete(FixedExpense fixedExpense) async {
    await _fixedExpenseRepository.delete(fixedExpense);
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
      var result = await _fixedExpenseRepository.findAll();
      result.onSuccess((success) {
        list = success;
        list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        notifyListeners();
      });
    }
  }

  pay(FixedExpense fixedExpense) async {
    var result = await _fixedExpenseRepository.pay(
      fixedExpense: fixedExpense,
      notificationTitle: _context.intl.fixedExpenseNotificationTitle,
    );
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      _doRefresh(true);
    });
  }
}
