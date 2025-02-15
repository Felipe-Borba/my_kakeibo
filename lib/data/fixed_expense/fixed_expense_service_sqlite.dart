import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseServiceSqlite {
  final SQLiteService _service;

  FixedExpenseServiceSqlite(this._service);

  Future<Result<FixedExpense>> insert(FixedExpense fixedExpense) async {
    try {
      final model = fixedExpense.toMap();
      model['fixed_expense_id'] = _service.generateId();

      final db = await _service.database;
      await db.insert(_service.fixedExpenseTable, model);

      return Success(fixedExpense.copyWith(id: model['fixed_expense_id']));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<FixedExpense>>> findAll() async {
    try {
      const query = '''
        SELECT *
        FROM fixed_expenses
        LEFT JOIN expense_categories ON fixed_expenses.expense_category_id = expense_categories.expense_category_id
      ''';
      final db = await _service.database;
      final result = await db.rawQuery(query);
      final list = result
          .map((e) => FixedExpense.fromMap(e, ExpenseCategory.fromMap(e), []))
          .toList();

      return Success(list);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<FixedExpense>> update(FixedExpense fixedExpense) async {
    try {
      final model = fixedExpense.toMap();
      final id = fixedExpense.id;

      final db = await _service.database;
      final count = await db.update(
        _service.fixedExpenseTable,
        model,
        where: 'fixed_expense_id = ?',
        whereArgs: [id],
      );

      if (count == 0) {
        return Failure(CustomException.fixedExpenseNotFound());
      }

      return Success(fixedExpense);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    try {
      final id = fixedExpense.id;

      final db = await _service.database;
      final count = await db.delete(
        _service.fixedExpenseTable,
        where: 'fixed_expense_id = ?',
        whereArgs: [id],
      );

      if (count == 0) {
        return Failure(CustomException.fixedExpenseNotFound());
      }

      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
