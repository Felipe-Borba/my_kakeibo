import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class IncomeServiceSqlite {
  final SQLiteService _service;

  IncomeServiceSqlite(this._service);

  AsyncResult<Income> insert(Income income) async {
    try {
      final model = income.toMap();
      model['id'] = _service.generateId();

      _service.database.insert(_service.incomeTable, model);

      return Success(income.copyWith(id: model['id']));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<List<Income>> findAll() async {
    try {
      const query = '''
        SELECT income_sources.*, income.*, income_sources.id as sourceId 
        FROM income
        LEFT JOIN income_sources ON income.sourceId = income_sources.id
      ''';
      final result = await _service.database.rawQuery(query);
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
        SELECT income_sources.*, income.*, income_sources.id as sourceId 
        FROM income 
        LEFT JOIN income_sources ON income.sourceId = income_sources.id
        WHERE date >= ? AND date <= ?
      ''';
      final result = await _service.database.rawQuery(
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

      final count = await _service.database.update(
        _service.incomeTable,
        model,
        where: 'id = ?',
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

      final count = await _service.database.delete(
        _service.incomeTable,
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
