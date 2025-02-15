// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:my_kakeibo/data/sqlite/migrations/0001_create_tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  static const tableProject = """
  CREATE TABLE IF NOT EXISTS expense_categories (
        id TEXT PRIMARY KEY,
        managerId TEXT,
        consultantID TEXT,
        name TEXT,
        description TEXT,
        created TEXT,
        deadline TEXT
      );""";
  static const tableAudit = """
  CREATE TABLE IF NOT EXISTS Audit (
        id TEXT PRIMARY key,
        projectId TEXT,
        timeTrackId TEXT,
        jsonChanges TEXT,
        date TEXT,
        employeeId TEXT
      );""";
  static const tableEmployee = """
  CREATE TABLE IF NOT EXISTS Employee (
        id TEXT PRIMARY key,
        fullName TEXT,
        managementLogonAccess INTEGER
      );""";
  static const tableJobPosition = """
  CREATE TABLE IF NOT EXISTS JobPosition (
        id TEXT PRIMARY KEY,
        name TEXT
      );""";
  static const tableWorkType = """
  CREATE TABLE IF NOT EXISTS WorkType (
        id TEXT PRIMARY key,
        name TEXT
      );""";
  static const tableAssignedJobPosition = """
  CREATE TABLE IF NOT EXISTS AssignedJobPosition (
        employeeId TEXT,
        positionId TEXT
      );""";
  static const tableTimeTrack = """
  CREATE TABLE IF NOT EXISTS TimeTrack (
        id TEXT PRIMARY key,
        timeSpan INTEGER,
        employeeId TEXT,
        projectId TEXT,
        workType TEXT,
        note TEXT,
        date TEXT
      );""";
  static const tableAllowedWorkType = """
  CREATE TABLE IF NOT EXISTS AllowedWorkType (
        projectId TEXT,
        workTypeId TEXT
      );""";

  Future<Database> initDB() async {
    print("initDB executed");
    //Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), "teste", "core.db");
    await deleteDatabase(path);
    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(createUsersTable);
        await db.execute(createExpensesTable);
        await db.execute(createIncomeTable);
        await db.execute(createFixedExpensesTable);
        await db.execute(createExpenseCategoriesTable);
        await db.execute(createIncomeSourcesTable);
        // await db.execute(tableEmployee);
        // await db.execute(tableAudit);
        // await db.execute(tableProject);
        // await db.execute(tableJobPosition);
        // await db.execute(tableWorkType);
        // await db.execute(tableAssignedJobPosition);
        // await db.execute(tableTimeTrack);
        // await db.execute(tableAllowedWorkType);
        // await db.insert('expense_categories', {
        //   'id': '1',
        //   'managerId': '123',
        //   'consultantID': '456',
        //   'name': 'Project 1',
        //   'description': 'Description of Project 1',
        //   'created': DateTime.now().toIso8601String(),
        //   'deadline': DateTime.now().add(Duration(days: 30)).toIso8601String(),
        // });
      },
    );
  }

  ///get all Projects
  Future/*<List<Project>>*/ getAllProjects() async {
    final db = await database;
    // return await db.query("expense_categories");
    return await db.query("income_sources");
    /*var res =
    return res.isNotEmpty ? res.map((c) => Project.fromMap(c, false)).toList() : [];*/
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    var res = await DBProvider.db.getAllProjects();
    print(res);
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
