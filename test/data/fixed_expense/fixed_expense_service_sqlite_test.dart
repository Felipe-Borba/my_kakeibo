import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/expense_category/expense_category_service_sqlite.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_service_sqlite.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SQLiteService sqliteService;
  late FixedExpenseServiceSqlite fixedExpenseService;

  late ExpenseCategory category;
  late ExpenseCategory category2;

  late FixedExpense fixedExpenseMock1;
  late FixedExpense fixedExpenseMock2;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    sqliteService = SQLiteService(version: 'test_fixed_expense');
    fixedExpenseService = FixedExpenseServiceSqlite(sqliteService);

    final categoryService = ExpenseCategoryServiceSqlite(sqliteService);
    category = await categoryService
        .insert(ExpenseCategory(
          color: ColorCustom.blue,
          icon: IconCustom.book,
          name: "Stub",
        ))
        .getOrThrow();
    category2 = await categoryService
        .insert(ExpenseCategory(
          color: ColorCustom.brown,
          icon: IconCustom.doctor,
          name: "Stub2",
        ))
        .getOrThrow();

    fixedExpenseMock1 = FixedExpense(
      amount: 1000.0,
      dueDate: DateTime.now(),
      description: 'Monthly Rent',
      category: category,
      frequency: Frequency.monthly,
      remember: Remember.no,
      expenseList: List.empty(),
    );

    fixedExpenseMock2 = FixedExpense(
      amount: 500.0,
      dueDate: DateTime.now(),
      description: 'Weekly Groceries',
      category: category,
      frequency: Frequency.weekly,
      remember: Remember.no,
      expenseList: List.empty(),
    );
  });

  tearDownAll(() async {
    final db = await sqliteService.database;
    await db.close();
    await sqliteService.dropDatabase();
  });

  group('FixedExpenseServiceSqlite', () {
    setUp(() async {
      final db = await sqliteService.database;
      await db.delete(sqliteService.fixedExpenseTable);
    });

    test(
      'should insert a fixed expense',
      () async {
        // Arrange
        final fixedExpense = fixedExpenseMock1;

        // Act
        final result = await fixedExpenseService.insert(fixedExpense);

        // Assert
        expect(result.isSuccess(), true);
        result.onSuccess((data) {
          expect(data.id, isNotNull);
          expect(data.amount, fixedExpense.amount);
          expect(data.dueDate, fixedExpense.dueDate);
          expect(data.description, fixedExpense.description);
          expect(data.category.id, category.id);
          expect(data.frequency, fixedExpense.frequency);
          expect(data.remember, fixedExpense.remember);
        });
        result.onFailure((error) {
          fail('Insert failed');
        });
      },
    );

    test(
      'should find all fixed expenses',
      () async {
        // Arrange
        final fixedExpense1 = await fixedExpenseService
            .insert(fixedExpenseMock1) //
            .getOrThrow();

        final fixedExpense2 = await fixedExpenseService
            .insert(fixedExpenseMock2) //
            .getOrThrow();

        // Act
        final result = await fixedExpenseService.findAll();

        // Assert
        expect(result.isSuccess(), true);
        result.onSuccess((data) {
          expect(data.length, 2);
          expect(data[0].id, fixedExpense1.id);
          expect(data[1].id, fixedExpense2.id);
        });
        result.onFailure((error) {
          fail('Find all failed');
        });
      },
    );

    test(
      'should update a fixed expense',
      () async {
        // Arrange
        final insertedExpense = await fixedExpenseService
            .insert(fixedExpenseMock1) //
            .getOrThrow();

        final updatedExpense = insertedExpense.copyWith(
          amount: 1200.0,
          dueDate: DateTime.now().add(const Duration(days: 1)),
          description: "Updated Rent",
          category: category2,
          frequency: Frequency.annually,
          remember: Remember.dayBefore,
        );

        // Act
        final updateResult = await fixedExpenseService.update(updatedExpense);

        // Assert
        expect(updateResult.isSuccess(), true);
        updateResult.onSuccess((data) {
          expect(data.amount, 1200.0);
        });
        updateResult.onFailure((error) {
          fail('Update failed');
        });
      },
    );

    test(
      'should return failure when updating non-existent fixed expense',
      () async {
        // Arrange
        final fixedExpense = FixedExpense(
          id: 'non-existent-id',
          amount: 1000.0,
          dueDate: DateTime.now(),
          description: 'Non-existent Expense',
          category: category,
          frequency: Frequency.monthly,
          remember: Remember.no,
          expenseList: List.empty(),
        );

        // Act
        final updateResult = await fixedExpenseService.update(fixedExpense);

        // Assert
        expect(updateResult.isError(), true);
        updateResult.onFailure((error) {
          expect(error, isA<CustomException>());
          if (error is CustomException) {
            expect(error.type, ExceptionType.fixedExpenseNotFound);
          }
        });
      },
    );

    test(
      'should delete a fixed expense',
      () async {
        // Arrange
        final fixedExpense = fixedExpenseMock1;

        final insertResult = await fixedExpenseService.insert(fixedExpense);
        final insertedExpense = insertResult.getOrThrow();

        // Act
        final deleteResult = await fixedExpenseService.delete(insertedExpense);

        // Assert
        expect(deleteResult.isSuccess(), true);
        deleteResult.onFailure((error) {
          fail('Delete failed');
        });

        final findResult = await fixedExpenseService.findAll();
        expect(findResult.isSuccess(), true);
        findResult.onSuccess((data) {
          expect(data.length, 0);
        });
      },
    );

    test(
      'should return failure when deleting non-existent fixed expense',
      () async {
        // Arrange
        final fixedExpense = FixedExpense(
          id: 'non-existent-id',
          amount: 1000.0,
          dueDate: DateTime.now(),
          description: 'Non-existent Expense',
          category: category,
          frequency: Frequency.monthly,
          remember: Remember.no,
          expenseList: List.empty(),
        );

        // Act
        final deleteResult = await fixedExpenseService.delete(fixedExpense);

        // Assert
        expect(deleteResult.isError(), true);
        deleteResult.onFailure((error) {
          expect(error, isA<CustomException>());
          if (error is CustomException) {
            expect(error.type, ExceptionType.fixedExpenseNotFound);
          }
        });
      },
    );

    test(
      'should delete all fixed expenses',
      () async {
        // Arrange
        await fixedExpenseService
            .insert(fixedExpenseMock1) //
            .getOrThrow();

        await fixedExpenseService
            .insert(fixedExpenseMock2) //
            .getOrThrow();

        // Act
        final deleteResult = await fixedExpenseService.deleteAll();

        // Assert
        expect(deleteResult.isSuccess(), true);
        deleteResult.onFailure((error) {
          fail('Delete all failed');
        });

        final findResult = await fixedExpenseService.findAll();
        expect(findResult.isSuccess(), true);
        findResult.onSuccess((data) {
          expect(data.length, 0);
        });
      },
    );

    test(
      'should insert a fixed expense and persist notification_id',
      () async {
        // Arrange
        final fixedExpense = fixedExpenseMock1.copyWith(
          notificationId: 1,
        );

        // Act
        final result = await fixedExpenseService.insert(fixedExpense);

        // Assert
        expect(result.isSuccess(), true);
        result.onSuccess((data) {
          expect(data.notificationId, 1);
        });
      },
    );

    test(
      'should find all fixed expenses and verify notification_id',
      () async {
        // Arrange
        await fixedExpenseService
            .insert(fixedExpenseMock1.copyWith(notificationId: 1))
            .getOrThrow();

        await fixedExpenseService
            .insert(fixedExpenseMock2.copyWith(notificationId: 2))
            .getOrThrow();

        // Act
        final result = await fixedExpenseService.findAll();

        // Assert
        expect(result.isSuccess(), true);
        result.onSuccess((data) {
          expect(data[0].notificationId, 1);
          expect(data[1].notificationId, 2);
        });
      },
    );

    //
  });
}
