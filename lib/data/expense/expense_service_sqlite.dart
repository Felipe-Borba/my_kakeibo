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
      model['expense_id'] = _service.generateId();

      final db = await _service.database;
      await db.insert(_service.expenseTable, model);

      return Success(expense.copyWith(id: model['expense_id']));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<Expense>> findAll() async {
    try {
      const query = '''
        SELECT t3.*, t2.*, t1.* 
        FROM expenses as t1
        LEFT JOIN expense_categories as t2 ON t1.expense_category_id = t2.expense_category_id
        LEFT JOIN fixed_expenses as t3 ON t1.fixed_expense_id = t3.fixed_expense_id
      ''';
      final db = await _service.database;
      final result = await db.rawQuery(query);
      final list = result
          .map((e) => Expense.fromMap(
                e,
                ExpenseCategory.fromMap(e),
                e['fixed_expense_id'] == null
                    ? null
                    : FixedExpense.fromMap(e, ExpenseCategory.fromMap(e), []),
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
        SELECT * 
        FROM expenses 
        LEFT JOIN expense_categories ON expenses.expense_category_id = expense_categories.expense_category_id
        WHERE expense_date >= ? AND expense_date <= ?
      ''';
      final db = await _service.database;
      final result = await db.rawQuery(
        query,
        [start.toIso8601String(), end.toIso8601String()],
      );
      final list = result
          .map((e) => Expense.fromMap(e, ExpenseCategory.fromMap(e), null))
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

      final db = await _service.database;
      final count = await db.update(
        _service.expenseTable,
        model,
        where: 'expense_id = ?',
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

      final db = await _service.database;
      final count = await db.delete(
        _service.expenseTable,
        where: 'expense_id = ?',
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
