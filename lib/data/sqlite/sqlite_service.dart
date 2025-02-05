import 'package:my_kakeibo/data/sqlite/migrations/0002_insert_default_values.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'migrations/0001_create_tables.dart';

class SQLiteService {
  SQLiteService._internal();
  static final SQLiteService _instance = SQLiteService._internal();
  late Database _database;
  final _uuid = const Uuid();

  factory SQLiteService() {
    return _instance;
  }

  String generateId() {
    return _uuid.v4();
  }

  Future<void> initialize() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_kakeibo.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createTables);
        await db.execute(insertDefaultValues);
      },
    );
  }

  Database get database => _database;
}
