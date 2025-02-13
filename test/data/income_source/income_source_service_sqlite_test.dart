import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/income_source/income_source_service_sqlite.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SQLiteService sqliteService;
  late IncomeSourceServiceSqlite service;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    sqliteService = SQLiteService();
    await sqliteService.initialize(version: 'test_income_source');
    service = IncomeSourceServiceSqlite(sqliteService);
  });

  tearDownAll(() async {
    await sqliteService.database.close();
    await sqliteService.dropDatabase(version: 'test_income_source');
  });

  group('ExpenseCategoryServiceSqlite', () {
    setUp(() async {
      await sqliteService.database.delete(sqliteService.incomeSourceTable);
    });

    test('should insert a incomeSource', () async {
      final incomeSource = IncomeSource(
        name: 'Test IncomeSource',
        color: ColorCustom.blue,
        icon: IconCustom.entertainment,
      );

      await service.insert(incomeSource);
      final result = await service.findAll();

      expect(result.isSuccess(), true);
      result.fold(
        (list) {
          final data = list.first;
          expect(data.id, isNotNull);
          expect(data.name, incomeSource.name);
          expect(data.color, incomeSource.color);
          expect(data.icon, incomeSource.icon);
        },
        (error) {
          fail('Insert failed');
        },
      );
    });

    test('should update a IncomeSource', () async {
      final incomeSource = await service
          .insert(IncomeSource(
            name: 'Test IncomeSource',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final updatedCategory = incomeSource.copyWith(
        name: "Updated name",
        color: ColorCustom.brown,
        icon: IconCustom.book,
      );
      final result = await service.update(updatedCategory);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.id, updatedCategory.id);
        expect(data.name, updatedCategory.name);
        expect(data.color, updatedCategory.color);
        expect(data.icon, updatedCategory.icon);
      });
      result.onFailure((error) {
        fail('Update failed');
      });
    });

    test("should throw an exception if id is null", () async {
      await service.insert(IncomeSource(
        name: 'Test IncomeSource',
        color: ColorCustom.blue,
        icon: IconCustom.entertainment,
      ));

      final userWithoutId = IncomeSource(
        id: sqliteService.generateId(),
        name: "Test ExpenseCategory2",
        color: ColorCustom.blue,
        icon: IconCustom.entertainment,
      );
      final result = await service.update(userWithoutId);

      expect(result.isError(), true);
      result.onSuccess((data) {
        fail('Update should have failed');
      });
      result.onFailure((error) {
        expect(error, isA<CustomException>());
        if (error is CustomException) {
          expect(error.type, ExceptionType.expenseCategoryNotFound);
        }
      });
    });

    test('should find IncomeSource by id', () async {
      final incomeSource = await service
          .insert(IncomeSource(
            name: 'Test IncomeSource',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final result = await service.findOne(incomeSource);

      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data.id, incomeSource.id);
          expect(data.name, incomeSource.name);
          expect(data.color, incomeSource.color);
          expect(data.icon, incomeSource.icon);
        },
        (error) {
          fail('Get IncomeSource failed');
        },
      );
    });

    test('should delete a IncomeSource', () async {
      final incomeSource = await service
          .insert(IncomeSource(
            name: 'Test IncomeSource',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final result = await service.delete(incomeSource);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data, unit);
      });
      result.onFailure((error) {
        fail('Delete failed');
      });

      final findResult = await service.findOne(incomeSource);
      expect(findResult.isError(), true);
      findResult.onFailure((error) {
        expect(error, isA<CustomException>());
        if (error is CustomException) {
          expect(error.type, ExceptionType.expenseCategoryNotFound);
        }
      });
    });

    test('should find all ExpenseCategories', () async {
      final expenseCategory1 = await service
          .insert(IncomeSource(
            name: 'Test IncomeSource 1',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final expenseCategory2 = await service
          .insert(IncomeSource(
            name: 'Test IncomeSource 2',
            color: ColorCustom.orange,
            icon: IconCustom.food,
          ))
          .getOrThrow();

      final result = await service.findAll();

      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data.length, 2);
          expect(data, containsAll([expenseCategory1, expenseCategory2]));
        },
        (error) {
          fail('Find all failed');
        },
      );
    });

    test('should return empty list if no ExpenseCategories found', () async {
      final result = await service.findAll();

      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data, isEmpty);
        },
        (error) {
          fail('Find all failed');
        },
      );
    });
  });
}
