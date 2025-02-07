import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseServiceSqlite {
  final SQLiteService _service;

  ExpenseServiceSqlite(this._service);

  AsyncResult<Expense> insert(Expense expense) async {
    try {
      final model = expense.toMap();
      model['id'] = _service.generateId();

      _service.database.insert(_service.expenseTable, model);

      return Success(expense.copyWith(id: model['id']));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<Expense>> findAll() async {
    try {
      const query = '''
        SELECT expense_categories.*, fixed_expenses.*, expenses.* 
        FROM expenses
        LEFT JOIN expense_categories ON expenses.categoryId = expense_categories.id
        LEFT JOIN fixed_expenses ON expenses.fixedExpenseId = fixed_expenses.id
      ''';
      final result = await _service.database.rawQuery(query);
      final list = result
          .map((e) => Expense.fromMap(
                e,
                ExpenseCategory.fromMap(e),
                FixedExpense.fromMap(e, ExpenseCategory.fromMap(e), []),
              ))
          .toList();

      return Success(list);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<Expense>> findByMonth({required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      const query = '''
        SELECT expense_categories.*, expenses.*, expense_categories.id as categoryId 
        FROM expenses 
        LEFT JOIN expense_categories ON expenses.categoryId = expense_categories.id
        WHERE date >= ? AND date <= ?
      ''';
      final result = await _service.database.rawQuery(
        query,
        [start.toIso8601String(), end.toIso8601String()],
      );
      final list = result
          .map((e) => Expense.fromMap(
                e,
                ExpenseCategory.fromMap(e),
                FixedExpense.fromMap(e, ExpenseCategory.fromMap(e), []),
              ))
          .toList();

      return Success(list);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Expense> update(Expense expense) async {
    try {
      final model = expense.toMap();
      final id = expense.id;

      final count = await _service.database.update(
        _service.expenseTable,
        model,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count == 0) {
        return Failure(CustomException.expenseNotFound());
      }

      return Success(expense);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Unit> delete(Expense expense) async {
    try {
      final id = expense.id;

      final count = await _service.database.delete(
        _service.expenseTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count == 0) {
        return Failure(CustomException.expenseNotFound());
      }

      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
