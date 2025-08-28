import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseCategoryServiceSqlite {
  final SQLiteService _sqliteService;

  ExpenseCategoryServiceSqlite(this._sqliteService);

  AsyncResult<ExpenseCategory> insert(
    ExpenseCategory expenseCategory,
  ) async {
    try {
      final insertedCategory = expenseCategory.copyWith(
        id: _sqliteService.generateId(),
      );
      final db = await _sqliteService.database;
      await db.insert(
        _sqliteService.expenseCategoryTable,
        insertedCategory.toMap(),
      );

      return Success(insertedCategory);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<ExpenseCategory>> findAll() async {
    try {
      final db = await _sqliteService.database;
      final result = await db.query(_sqliteService.expenseCategoryTable);
      final expenseCategories =
          result.map((e) => ExpenseCategory.fromMap(e)).toList();

      return Success(expenseCategories);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<ExpenseCategory> findOne(
    ExpenseCategory expenseCategory,
  ) async {
    try {
      final db = await _sqliteService.database;
      final result = await db.query(
        _sqliteService.expenseCategoryTable,
        where: 'expense_category_id = ?',
        whereArgs: [expenseCategory.id],
      );

      if (result.isEmpty) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      final expenseCategoryMap = result.first;
      final foundExpenseCategory = ExpenseCategory.fromMap(expenseCategoryMap);
      return Success(foundExpenseCategory);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<ExpenseCategory> update(
    ExpenseCategory expenseCategory,
  ) async {
    try {
      final db = await _sqliteService.database;
      final rowsAffected = await db.update(
        _sqliteService.expenseCategoryTable,
        expenseCategory.toMap(),
        where: 'expense_category_id = ?',
        whereArgs: [expenseCategory.id],
      );

      if (rowsAffected == 0) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      return Success(expenseCategory);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Unit> delete(ExpenseCategory expenseCategory) async {
    try {
      final db = await _sqliteService.database;
      final rowsDeleted = await db.delete(
        _sqliteService.expenseCategoryTable,
        where: 'expense_category_id = ?',
        whereArgs: [expenseCategory.id],
      );

      if (rowsDeleted == 0) {
        return Failure(CustomException.expenseCategoryNotFound());
      }
      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Unit> deleteAll() async {
    try {
      final db = await _sqliteService.database;
      await db.delete(_sqliteService.expenseCategoryTable);
      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
