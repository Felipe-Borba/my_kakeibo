import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/expense_category/expense_category_service_sqlite.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SQLiteService sqliteService;
  late ExpenseCategoryServiceSqlite service;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    sqliteService = SQLiteService();
    await sqliteService.initialize();
    service = ExpenseCategoryServiceSqlite(sqliteService);
    await sqliteService.database.delete('expense_categories');
  });

  tearDownAll(() async {
    await sqliteService.database.close();
  });

  group('ExpenseCategoryServiceSqlite', () {
    tearDown(() async {
      await sqliteService.database.delete('expense_categories');
    });

    test('should insert a expenseCategory', () async {
      final expenseCategory = ExpenseCategory(
        name: 'Test ExpenseCategory',
        color: ColorCustom.blue,
        icon: IconCustom.entertainment,
      );

      final result = await service.insert(expenseCategory);
      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data.id, isNotNull);
          expect(data.name, expenseCategory.name);
          expect(data.color, expenseCategory.color);
          expect(data.icon, expenseCategory.icon);
        },
        (error) {
          fail('Insert failed');
        },
      );
    });

    test('should update a ExpenseCategory', () async {
      final expenseCategory = await service
          .insert(ExpenseCategory(
            name: 'Test ExpenseCategory',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final updatedCategory = expenseCategory.copyWith(
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
      await service.insert(ExpenseCategory(
        name: 'Test ExpenseCategory',
        color: ColorCustom.blue,
        icon: IconCustom.entertainment,
      ));

      final userWithoutId = ExpenseCategory(
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

    test('should find ExpenseCategory by id', () async {
      final expenseCategory = await service
          .insert(ExpenseCategory(
            name: 'Test ExpenseCategory',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final result = await service.findOne(expenseCategory);

      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data.id, expenseCategory.id);
          expect(data.name, expenseCategory.name);
          expect(data.color, expenseCategory.color);
          expect(data.icon, expenseCategory.icon);
        },
        (error) {
          fail('Get ExpenseCategory failed');
        },
      );
    });

    test('should delete a ExpenseCategory', () async {
      final expenseCategory = await service
          .insert(ExpenseCategory(
            name: 'Test ExpenseCategory',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final result = await service.delete(expenseCategory);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data, unit);
      });
      result.onFailure((error) {
        fail('Delete failed');
      });

      final findResult = await service.findOne(expenseCategory);
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
          .insert(ExpenseCategory(
            name: 'Test ExpenseCategory 1',
            color: ColorCustom.blue,
            icon: IconCustom.entertainment,
          ))
          .getOrThrow();

      final expenseCategory2 = await service
          .insert(ExpenseCategory(
            name: 'Test ExpenseCategory 2',
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
