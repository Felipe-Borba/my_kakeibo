import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/expense_category/expense_category_form/expense_category_form_view.dart';

class ExpenseCategoryListViewModel with ChangeNotifier {
  ExpenseCategoryListViewModel(this._context) {
    getInitialData();
  }

  // Dependencies
  late final expenseUseCase =
      _context.dependencyManager.expenseCategoryRealmRepository;
  final BuildContext _context;

  // State
  List<ExpenseCategory> list = List.empty();

  // Actions
  getInitialData() async {
    var result = await expenseUseCase.findAll();
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      list = success;
    });

    notifyListeners();
  }

  onDelete(ExpenseCategory expense) async {
    await expenseUseCase.delete(expense);
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
      var result = await expenseUseCase.findAll();
      result.onSuccess((success) {
        list = success;
        notifyListeners();
      });
    }
  }
}
