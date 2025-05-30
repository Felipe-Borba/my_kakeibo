import 'package:my_kakeibo/data/sqlite/migrations/0002_update_user_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'migrations/0001_create_tables.dart';

class SQLiteService {
  SQLiteService._internal();
  static final SQLiteService _instance = SQLiteService._internal();
  late String _version;
  static Database? _database;
  final _uuid = const Uuid();

  final userTable = "users";
  final fixedExpenseTable = "fixed_expenses";
  final expenseTable = "expenses";
  final expenseCategoryTable = "expense_categories";
  final incomeTable = "income";
  final incomeSourceTable = "income_sources";

  factory SQLiteService({version = "prod"}) {
    _instance._version = version;
    return _instance;
  }

  String generateId() {
    return _uuid.v4();
  }

  Future<Database> _initialize() async {
    final basePath = await getDatabasesPath();
    final path = join(basePath, _version, 'my_kakeibo.db');

    return await openDatabase(
      path,
      version: 3,
      singleInstance: true,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute(createUsersTable);
        await db.execute(createExpensesTable);
        await db.execute(createIncomeTable);
        await db.execute(createFixedExpensesTable);
        await db.execute(createExpenseCategoriesTable);
        await db.execute(createIncomeSourcesTable);
        await db.execute(updateUserTable);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE $userTable');
          await db.execute('DROP TABLE $expenseTable');
          await db.execute('DROP TABLE $incomeTable');
          await db.execute('DROP TABLE $fixedExpenseTable');
          await db.execute('DROP TABLE $expenseCategoryTable');
          await db.execute('DROP TABLE $incomeSourceTable');
          await db.execute(createUsersTable);
          await db.execute(createExpensesTable);
          await db.execute(createIncomeTable);
          await db.execute(createFixedExpensesTable);
          await db.execute(createExpenseCategoriesTable);
          await db.execute(createIncomeSourcesTable);
        }
        if (oldVersion < 3) {
          await db.execute(updateUserTable);
        }
      },
    );
  }

  Future<void> dropDatabase() async {
    final path = join(await getDatabasesPath(), _version, 'my_kakeibo.db');
    await deleteDatabase(path);
  }

  Future<void> close() async {
    await _database?.close();
  }

  Future<Database> get database async {
    _database ??= await _initialize();
    return _database!;
  }
}
