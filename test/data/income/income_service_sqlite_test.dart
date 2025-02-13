import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/income/income_service_sqlite.dart';
import 'package:my_kakeibo/data/income_source/income_source_service_sqlite.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SQLiteService sqliteService;
  late IncomeServiceSqlite incomeService;

  late IncomeSource source;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    sqliteService = SQLiteService();
    await sqliteService.initialize(version: 'test_income');

    incomeService = IncomeServiceSqlite(sqliteService);
    source = await IncomeSourceServiceSqlite(sqliteService)
        .insert(IncomeSource(
          color: ColorCustom.blue,
          icon: IconCustom.book,
          name: "Stub",
        ))
        .getOrThrow();
  });

  tearDownAll(() async {
    await sqliteService.database.close();
    await sqliteService.dropDatabase(version: 'test_income');
  });

  group('IncomeServiceSqlite', () {
    setUp(() async {
      await sqliteService.database.delete(sqliteService.incomeTable);
    });

    test('should insert an income', () async {
      final income = Income(
        amount: 50.0,
        date: DateTime.now(),
        description: 'Groceries',
        source: source,
      );

      final result = await incomeService.insert(income);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.id, isNotNull);
        expect(data.amount, income.amount);
        expect(data.date, income.date);
        expect(data.description, income.description);
        expect(data.source.id, source.id);
      });
      result.onFailure((error) {
        fail('Insert failed');
      });
    });

    test('should find all incomes', () async {
      final income1 = await incomeService
          .insert(Income(
            amount: 50.0,
            date: DateTime.now(),
            description: 'Groceries',
            source: source,
          ))
          .getOrThrow();

      final income2 = await incomeService
          .insert(Income(
            amount: 30.0,
            date: DateTime.now(),
            description: 'Restaurant',
            source: source,
          ))
          .getOrThrow();

      final result = await incomeService.findAll();

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.length, 2);
        expect(data[0].id, income1.id);
        expect(data[0].amount, income1.amount);
        expect(data[0].date, income1.date);
        expect(data[0].description, income1.description);
        expect(data[0].source.id, income1.source.id);
        expect(data[1].amount, income2.amount);
        expect(data[1].date, income2.date);
        expect(data[1].description, income2.description);
        expect(data[1].source.id, income2.source.id);
        expect(data[1].id, income2.id);
      });
      result.onFailure((error) {
        fail('Find all failed');
      });
    });

    test('should find incomes by month', () async {
      final now = DateTime.now();
      final income1 = await incomeService
          .insert(Income(
            amount: 50.0,
            date: now,
            description: 'Groceries',
            source: source,
          ))
          .getOrThrow();

      await incomeService
          .insert(Income(
            amount: 30.0,
            date: now.add(const Duration(days: 100)),
            description: 'Restaurant',
            source: source,
          ))
          .getOrThrow();

      final income2 = await incomeService
          .insert(Income(
            amount: 30.0,
            date: now,
            description: 'Restaurant',
            source: source,
          ))
          .getOrThrow();

      final result = await incomeService.findByMonth(month: now);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.length, 2);
        expect(data[0].id, income1.id);
        expect(data[0].amount, income1.amount);
        expect(data[0].date, income1.date);
        expect(data[0].description, income1.description);
        expect(data[0].source.id, income1.source.id);
        expect(data[1].amount, income2.amount);
        expect(data[1].date, income2.date);
        expect(data[1].description, income2.description);
        expect(data[1].source.id, income2.source.id);
        expect(data[1].id, income2.id);
      });
      result.onFailure((error) {
        fail('Find by month failed');
      });
    });

    test('should update an income', () async {
      final income = await incomeService
          .insert(Income(
            amount: 50.0,
            date: DateTime.now(),
            description: 'Groceries',
            source: source,
          ))
          .getOrThrow();

      final updatedIncome =
          income.copyWith(amount: 100.0, description: 'Updated Groceries');
      final result = await incomeService.update(updatedIncome);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.id, income.id);
        expect(data.amount, 100.0);
        expect(data.description, 'Updated Groceries');
      });
      result.onFailure((error) {
        fail('Update failed');
      });
    });

    test('should delete an income', () async {
      final income = await incomeService
          .insert(Income(
            amount: 50.0,
            date: DateTime.now(),
            description: 'Groceries',
            source: source,
          ))
          .getOrThrow();

      final result = await incomeService.delete(income);

      expect(result.isSuccess(), true);
      result.onFailure((error) {
        fail('Delete failed');
      });

      final findResult = await incomeService.findAll();
      expect(findResult.isSuccess(), true);
      findResult.onSuccess((data) {
        expect(data.length, 0);
      });
    });
  });
}
