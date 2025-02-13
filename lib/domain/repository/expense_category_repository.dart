import 'package:my_kakeibo/data/expense_category/expense_category_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseCategoryRepository {
  final ExpenseCategoryServiceSqlite _expenseCategoryRealmService;

  ExpenseCategoryRepository(this._expenseCategoryRealmService);

  Future<Result<ExpenseCategory>> save(ExpenseCategory expenseCategory) {
    if (expenseCategory.id == null) {
      return _expenseCategoryRealmService.insert(expenseCategory);
    } else {
      return _expenseCategoryRealmService.update(expenseCategory);
    }
  }

  Future<Result<List<ExpenseCategory>>> findAll() {
    return _expenseCategoryRealmService.findAll();
  }

  Future<Result<void>> delete(ExpenseCategory expenseCategory) {
    return _expenseCategoryRealmService.delete(expenseCategory);
  }
}
