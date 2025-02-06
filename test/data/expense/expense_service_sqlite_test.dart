import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/expense_category/expense_category_service_sqlite.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SQLiteService sqliteService;
  late ExpenseServiceSqlite expenseService;

  late ExpenseCategory category;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    sqliteService = SQLiteService();
    await sqliteService.initialize();
    expenseService = ExpenseServiceSqlite(sqliteService);
    await sqliteService.database.delete('expenses');
    await sqliteService.database.delete('expense_categories');
    category = await ExpenseCategoryServiceSqlite(sqliteService)
        .insert(ExpenseCategory(
          color: ColorCustom.blue,
          icon: IconCustom.book,
          name: "Stub",
        ))
        .getOrThrow();
  });

  tearDown(() async {
    await sqliteService.database.delete('expense_categories');
    final db = sqliteService.database;
    await db.close();
  });

  group('ExpenseServiceSqlite', () {
    tearDown(() async {
      await sqliteService.database.delete('expenses');
    });

    test('should insert an expense', () async {
      final expense = Expense(
        amount: 50.0,
        date: DateTime.now(),
        description: 'Groceries',
        category: category,
      );

      final result = await expenseService.insert(expense);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.id, isNotNull);
        expect(data.amount, expense.amount);
        expect(data.date, expense.date);
        expect(data.description, expense.description);
        expect(data.category.id, category.id);
      });
      result.onFailure((error) {
        fail('Insert failed');
      });
    });

    test('should find all expenses', () async {
      final expense1 = await expenseService
          .insert(Expense(
            amount: 50.0,
            date: DateTime.now(),
            description: 'Groceries',
            category: category,
          ))
          .getOrThrow();

      final expense2 = await expenseService
          .insert(Expense(
            amount: 30.0,
            date: DateTime.now(),
            description: 'Restaurant',
            category: category,
          ))
          .getOrThrow();

      final result = await expenseService.findAll();

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.length, 2);
        expect(data[0].id, expense1.id);
        expect(data[0].amount, expense1.amount);
        expect(data[0].date, expense1.date);
        expect(data[0].description, expense1.description);
        expect(data[0].category.id, expense1.category.id);
        expect(data[1].amount, expense2.amount);
        expect(data[1].date, expense2.date);
        expect(data[1].description, expense2.description);
        expect(data[1].category.id, expense2.category.id);
        expect(data[1].id, expense2.id);
      });
      result.onFailure((error) {
        fail('Find all failed');
      });
    });

    test('should find expenses by month', () async {
      final now = DateTime.now();
      final expense1 = await expenseService
          .insert(Expense(
            amount: 50.0,
            date: now,
            description: 'Groceries',
            category: category,
          ))
          .getOrThrow();

      await expenseService
          .insert(Expense(
            amount: 30.0,
            date: now.add(const Duration(days: 100)),
            description: 'Restaurant',
            category: category,
          ))
          .getOrThrow();

      final expense2 = await expenseService
          .insert(Expense(
            amount: 30.0,
            date: now,
            description: 'Restaurant',
            category: category,
          ))
          .getOrThrow();

      final result = await expenseService.findByMonth(month: now);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.length, 2);
        expect(data[0].id, expense1.id);
        expect(data[0].amount, expense1.amount);
        expect(data[0].date, expense1.date);
        expect(data[0].description, expense1.description);
        expect(data[0].category.id, expense1.category.id);
        expect(data[1].amount, expense2.amount);
        expect(data[1].date, expense2.date);
        expect(data[1].description, expense2.description);
        expect(data[1].category.id, expense2.category.id);
        expect(data[1].id, expense2.id);
      });
      result.onFailure((error) {
        fail('Find by month failed');
      });
    });

    test('should update an expense', () async {
      final expense = await expenseService
          .insert(Expense(
            amount: 50.0,
            date: DateTime.now(),
            description: 'Groceries',
            category: category,
          ))
          .getOrThrow();

      final updatedExpense =
          expense.copyWith(amount: 100.0, description: 'Updated Groceries');
      final result = await expenseService.update(updatedExpense);

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data.id, expense.id);
        expect(data.amount, 100.0);
        expect(data.description, 'Updated Groceries');
      });
      result.onFailure((error) {
        fail('Update failed');
      });
    });

    test('should delete an expense', () async {
      final expense = await expenseService
          .insert(Expense(
            amount: 50.0,
            date: DateTime.now(),
            description: 'Groceries',
            category: category,
          ))
          .getOrThrow();

      final result = await expenseService.delete(expense);

      expect(result.isSuccess(), true);
      result.onFailure((error) {
        fail('Delete failed');
      });

      final findResult = await expenseService.findAll();
      expect(findResult.isSuccess(), true);
      findResult.onSuccess((data) {
        expect(data.length, 0);
      });
    });
  });
}
