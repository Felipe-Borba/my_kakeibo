import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/entity/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class IncomeServiceSqlite {
  final SQLiteService _service;

  IncomeServiceSqlite(this._service);

  AsyncResult<Income> insert(Income income) async {
    try {
      final model = income.toMap();
      model['income_id'] = _service.generateId();

      final db = await _service.database;
      await db.insert(_service.incomeTable, model);

      return Success(income.copyWith(id: model['income_id']));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<Income>> findAll() async {
    try {
      const query = '''
        SELECT * 
        FROM income as t1
        LEFT JOIN income_sources as t2 ON t1.income_source_id = t2.income_source_id
      ''';
      final db = await _service.database;
      final result = await db.rawQuery(query);
      final list = result
          .map((e) => Income.fromMap(e, IncomeSource.fromMap(e)))
          .toList();

      return Success(list);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<Income>> findByMonth({required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      const query = '''
        SELECT *
        FROM income as t1
        LEFT JOIN income_sources as t2 ON t1.income_source_id = t2.income_source_id
        WHERE income_date >= ? AND income_date <= ?
      ''';
      final db = await _service.database;
      final result = await db.rawQuery(
        query,
        [start.toIso8601String(), end.toIso8601String()],
      );
      final list = result
          .map((e) => Income.fromMap(e, IncomeSource.fromMap(e)))
          .toList();

      return Success(list);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Income> update(Income income) async {
    try {
      final model = income.toMap();
      final id = income.id;

      final db = await _service.database;
      final count = await db.update(
        _service.incomeTable,
        model,
        where: 'income_id = ?',
        whereArgs: [id],
      );

      if (count == 0) {
        return Failure(CustomException.expenseNotFound());
      }

      return Success(income);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Unit> delete(Income income) async {
    try {
      final id = income.id;

      final db = await _service.database;
      final count = await db.delete(
        _service.incomeTable,
        where: 'income_id = ?',
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

  AsyncResult<Unit> deleteAll() async {
    try {
      final db = await _service.database;
      await db.delete(_service.incomeTable);

      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
