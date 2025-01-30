import 'package:flutter/material.dart';
import 'package:my_kakeibo/data/repository/expense_category_repository.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/expense_category/expense_category_form/expense_category_form_view.dart';

class ExpenseCategoryListViewModel with ChangeNotifier {
  ExpenseCategoryListViewModel(this._context, this._expenseCategoryRepository) {
    getInitialData();
  }

  // Dependencies
  final ExpenseCategoryRepository _expenseCategoryRepository;
  final BuildContext _context;

  // State
  List<ExpenseCategory> list = List.empty();

  // Actions
  getInitialData() async {
    var result = await _expenseCategoryRepository.findAll();
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      list = success;
    });

    notifyListeners();
  }

  onDelete(ExpenseCategory expense) async {
    await _expenseCategoryRepository.delete(expense);
    _doRefresh(true);
  }

  onEdit(ExpenseCategory expense) async {
    var refresh = await _context.pushScreen(
      ExpenseCategoryFormView(expenseCategory: expense),
    );
    await _doRefresh(refresh);
  }

  onAdd() async {
    var refresh = await _context.pushScreen(const ExpenseCategoryFormView());
    await _doRefresh(refresh);
  }

  _doRefresh(bool? refresh) async {
    if (refresh == true) {
      var result = await _expenseCategoryRepository.findAll();
      result.onSuccess((success) {
        list = success;
        notifyListeners();
      });
    }
  }
}
