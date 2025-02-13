import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class IncomeSourceServiceSqlite {
  final SQLiteService _sqliteService;

  IncomeSourceServiceSqlite(this._sqliteService);

  AsyncResult<IncomeSource> insert(
    IncomeSource incomeSource,
  ) async {
    try {
      final insertedCategory = incomeSource.copyWith(
        id: _sqliteService.generateId(),
      );

      await _sqliteService.database.insert(
        _sqliteService.incomeSourceTable,
        insertedCategory.toMap(),
      );

      return Success(insertedCategory);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<IncomeSource>> findAll() async {
    try {
      final result = await _sqliteService.database.query(
        _sqliteService.incomeSourceTable,
      );
      final expenseCategories =
          result.map((e) => IncomeSource.fromMap(e)).toList();

      return Success(expenseCategories);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<IncomeSource> findOne(
    IncomeSource incomeSource,
  ) async {
    try {
      final result = await _sqliteService.database.query(
        _sqliteService.incomeSourceTable,
        where: 'id = ?',
        whereArgs: [incomeSource.id],
      );

      if (result.isEmpty) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      final expenseCategoryMap = result.first;
      final foundExpenseCategory = IncomeSource.fromMap(expenseCategoryMap);
      return Success(foundExpenseCategory);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<IncomeSource> update(
    IncomeSource incomeSource,
  ) async {
    try {
      final rowsAffected = await _sqliteService.database.update(
        _sqliteService.incomeSourceTable,
        incomeSource.toMap(),
        where: 'id = ?',
        whereArgs: [incomeSource.id],
      );

      if (rowsAffected == 0) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      return Success(incomeSource);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Unit> delete(IncomeSource incomeSource) async {
    try {
      final rowsDeleted = await _sqliteService.database.delete(
        _sqliteService.incomeSourceTable,
        where: 'id = ?',
        whereArgs: [incomeSource.id],
      );

      if (rowsDeleted == 0) {
        return Failure(CustomException.expenseCategoryNotFound());
      }
      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
