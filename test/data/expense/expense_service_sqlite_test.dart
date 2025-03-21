import 'package:flutter_test/flutter_test.dart';
import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/expense_category/expense_category_service_sqlite.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_service_sqlite.dart';
import 'package:my_kakeibo/data/sqlite/sqlite_service.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late SQLiteService sqliteService;
  late ExpenseServiceSqlite expenseService;
  late ExpenseCategoryServiceSqlite expenseCategoryService;

  late ExpenseCategory category;
  late FixedExpense fixedExpense;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    sqliteService = SQLiteService(version: 'test_expense');
    expenseService = ExpenseServiceSqlite(sqliteService);
    expenseCategoryService = ExpenseCategoryServiceSqlite(sqliteService);

    category = await expenseCategoryService
        .insert(ExpenseCategory(
          color: ColorCustom.blue,
          icon: IconCustom.book,
          name: "Stub",
        ))
        .getOrThrow();
    fixedExpense = await FixedExpenseServiceSqlite(sqliteService)
        .insert(FixedExpense(
          amount: 50.0,
          dueDate: DateTime.now(),
          description: 'Stub',
          frequency: Frequency.daily,
          remember: Remember.no,
          category: category,
          expenseList: [],
        ))
        .getOrThrow();
  });

  tearDownAll(() async {
    final db = await sqliteService.database;
    await db.close();
    await sqliteService.dropDatabase();
  });

  group('ExpenseServiceSqlite', () {
    setUp(() async {
      final db = await sqliteService.database;
      await db.delete(sqliteService.expenseTable);
    });

    test('should insert an expense', () async {
      final expense = Expense(
        amount: 50.0,
        date: DateTime.now(),
        description: 'Groceries',
        category: category,
      );

      await expenseService.insert(expense);
      final result = await expenseService.findAll();

      expect(result.isSuccess(), true);
      result.onSuccess((list) {
        final data = list.first;
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
            fixedExpense: fixedExpense,
          ))
          .getOrThrow();

      final expense2 = await expenseService
          .insert(Expense(
            amount: 30.0,
            date: DateTime.now(),
            description: 'Restaurant',
            category: category,
            fixedExpense: fixedExpense,
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
        expect(data[0].fixedExpense?.id, expense1.fixedExpense?.id);
        expect(data[1].amount, expense2.amount);
        expect(data[1].date, expense2.date);
        expect(data[1].description, expense2.description);
        expect(data[1].category.id, expense2.category.id);
        expect(data[1].id, expense2.id);
        expect(data[1].fixedExpense?.id, expense2.fixedExpense?.id);
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

    test('should delete all expenses', () async {
      await expenseService
          .insert(Expense(
            amount: 50.0,
            date: DateTime.now(),
            description: 'Groceries',
            category: category,
          ))
          .getOrThrow();
      await expenseService
          .insert(Expense(
            amount: 30.0,
            date: DateTime.now(),
            description: 'Restaurant',
            category: category,
          ))
          .getOrThrow();

      final result = await expenseService.deleteAll();

      expect(result.isSuccess(), true);
      result.onSuccess((data) {
        expect(data, unit);
      });
      result.onFailure((error) {
        fail('Delete all failed');
      });

      final findResult = await expenseService.findAll();
      expect(findResult.isSuccess(), true);
      findResult.onSuccess((data) {
        expect(data.length, 0);
      });
    });

    test('should delete category and related expenses', () async {
      final newCategory = await expenseCategoryService
          .insert(ExpenseCategory(
            color: ColorCustom.green,
            icon: IconCustom.misc,
            name: "Transport",
          ))
          .getOrThrow();

      await expenseService
          .insert(Expense(
            amount: 20.0,
            date: DateTime.now(),
            description: 'Bus fare',
            category: newCategory,
          ))
          .getOrThrow();

      final deleteCategoryResult =
          await expenseCategoryService.delete(newCategory);

      expect(deleteCategoryResult.isSuccess(), true);
      deleteCategoryResult.onFailure((error) {
        fail('Delete category failed');
      });

      final findExpensesResult = await expenseService.findAll();
      expect(findExpensesResult.isSuccess(), true);
      findExpensesResult.onSuccess((data) {
        expect(data.length, 0);
      });
    });
  });
}
