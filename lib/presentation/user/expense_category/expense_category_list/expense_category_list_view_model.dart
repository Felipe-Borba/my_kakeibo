import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/repository/expense_category_repository.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/presentation/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/expense_category/expense_category_form/expense_category_form_view.dart';

class ExpenseCategoryListViewModel with ChangeNotifier {
  ExpenseCategoryListViewModel(
      this._context, this._expenseCategoryRepository, this._expenseRepository) {
    getInitialData();
  }

  // Dependencies
  final ExpenseCategoryRepository _expenseCategoryRepository;
  final ExpenseRepository _expenseRepository;
  final BuildContext _context;

  // State
  List<ExpenseCategory> list = List.empty();
  Map<String?, int> expenseCountByCategory = {};

  // Actions
  getInitialData() async {
    var result = await _expenseCategoryRepository.findAll();
    result.onFailure((failure) {
      showSnackbar(context: _context, text: failure.toString());
    });
    result.onSuccess((success) {
      list = success;
    });

    var expensesResult = await _expenseRepository.findAll();
    expensesResult.onSuccess((expenses) {
      expenseCountByCategory = {};
      for (var expense in expenses) {
        final categoryId = expense.category.id;
        if (categoryId != null) {
          expenseCountByCategory[categoryId] =
              (expenseCountByCategory[categoryId] ?? 0) + 1;
        }
      }
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

        // Atualizar contagem de despesas por categoria
        _expenseRepository.findAll().then((expensesResult) {
          expensesResult.onSuccess((expenses) {
            // Calcular contagem de despesas por categoria
            expenseCountByCategory = {};
            for (var expense in expenses) {
              final categoryId = expense.category.id;
              if (categoryId != null) {
                expenseCountByCategory[categoryId] =
                    (expenseCountByCategory[categoryId] ?? 0) + 1;
              }
            }
            notifyListeners();
          });
        });
      });
    }
  }
}
