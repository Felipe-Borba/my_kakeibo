// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ExpenseCategoryModel extends _ExpenseCategoryModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ExpenseCategoryModel(
    String id,
    String name,
    int _colorValue,
    int _iconValue, {
    Iterable<ExpenseModel> expenses = const [],
    Iterable<FixedExpenseModel> fixedExpenses = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'color', _colorValue);
    RealmObjectBase.set(this, 'icon', _iconValue);
    RealmObjectBase.set<RealmList<ExpenseModel>>(
        this, 'expenses', RealmList<ExpenseModel>(expenses));
    RealmObjectBase.set<RealmList<FixedExpenseModel>>(
        this, 'fixedExpenses', RealmList<FixedExpenseModel>(fixedExpenses));
  }

  ExpenseCategoryModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get _colorValue => RealmObjectBase.get<int>(this, 'color') as int;
  @override
  set _colorValue(int value) => RealmObjectBase.set(this, 'color', value);

  @override
  int get _iconValue => RealmObjectBase.get<int>(this, 'icon') as int;
  @override
  set _iconValue(int value) => RealmObjectBase.set(this, 'icon', value);

  @override
  RealmList<ExpenseModel> get expenses =>
      RealmObjectBase.get<ExpenseModel>(this, 'expenses')
          as RealmList<ExpenseModel>;
  @override
  set expenses(covariant RealmList<ExpenseModel> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<FixedExpenseModel> get fixedExpenses =>
      RealmObjectBase.get<FixedExpenseModel>(this, 'fixedExpenses')
          as RealmList<FixedExpenseModel>;
  @override
  set fixedExpenses(covariant RealmList<FixedExpenseModel> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ExpenseCategoryModel>> get changes =>
      RealmObjectBase.getChanges<ExpenseCategoryModel>(this);

  @override
  Stream<RealmObjectChanges<ExpenseCategoryModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ExpenseCategoryModel>(this, keyPaths);

  @override
  ExpenseCategoryModel freeze() =>
      RealmObjectBase.freezeObject<ExpenseCategoryModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'color': _colorValue.toEJson(),
      'icon': _iconValue.toEJson(),
      'expenses': expenses.toEJson(),
      'fixedExpenses': fixedExpenses.toEJson(),
    };
  }

  static EJsonValue _toEJson(ExpenseCategoryModel value) => value.toEJson();
  static ExpenseCategoryModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'color': EJsonValue _colorValue,
        'icon': EJsonValue _iconValue,
      } =>
        ExpenseCategoryModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(_colorValue),
          fromEJson(_iconValue),
          expenses: fromEJson(ejson['expenses']),
          fixedExpenses: fromEJson(ejson['fixedExpenses']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ExpenseCategoryModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, ExpenseCategoryModel, 'ExpenseCategoryModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('_colorValue', RealmPropertyType.int, mapTo: 'color'),
      SchemaProperty('_iconValue', RealmPropertyType.int, mapTo: 'icon'),
      SchemaProperty('expenses', RealmPropertyType.object,
          linkTarget: 'ExpenseModel', collectionType: RealmCollectionType.list),
      SchemaProperty('fixedExpenses', RealmPropertyType.object,
          linkTarget: 'FixedExpenseModel',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class ExpenseModel extends _ExpenseModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ExpenseModel(
    String id,
    double amount,
    DateTime date,
    String description, {
    ExpenseCategoryModel? category,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'category', category);
  }

  ExpenseModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  ExpenseCategoryModel? get category =>
      RealmObjectBase.get<ExpenseCategoryModel>(this, 'category')
          as ExpenseCategoryModel?;
  @override
  set category(covariant ExpenseCategoryModel? value) =>
      RealmObjectBase.set(this, 'category', value);

  @override
  Stream<RealmObjectChanges<ExpenseModel>> get changes =>
      RealmObjectBase.getChanges<ExpenseModel>(this);

  @override
  Stream<RealmObjectChanges<ExpenseModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ExpenseModel>(this, keyPaths);

  @override
  ExpenseModel freeze() => RealmObjectBase.freezeObject<ExpenseModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'amount': amount.toEJson(),
      'date': date.toEJson(),
      'description': description.toEJson(),
      'category': category.toEJson(),
    };
  }

  static EJsonValue _toEJson(ExpenseModel value) => value.toEJson();
  static ExpenseModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'amount': EJsonValue amount,
        'date': EJsonValue date,
        'description': EJsonValue description,
      } =>
        ExpenseModel(
          fromEJson(id),
          fromEJson(amount),
          fromEJson(date),
          fromEJson(description),
          category: fromEJson(ejson['category']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ExpenseModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, ExpenseModel, 'ExpenseModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'ExpenseCategoryModel'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class FixedExpenseModel extends _FixedExpenseModel
    with RealmEntity, RealmObjectBase, RealmObject {
  FixedExpenseModel(
    String id,
    DateTime dueDate,
    String description,
    double amount,
    String frequencyString,
    String rememberString, {
    Iterable<String> expenseIdList = const [],
    ExpenseCategoryModel? category,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'dueDate', dueDate);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'frequencyString', frequencyString);
    RealmObjectBase.set(this, 'rememberString', rememberString);
    RealmObjectBase.set<RealmList<String>>(
        this, 'expenseIdList', RealmList<String>(expenseIdList));
    RealmObjectBase.set(this, 'category', category);
  }

  FixedExpenseModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  DateTime get dueDate =>
      RealmObjectBase.get<DateTime>(this, 'dueDate') as DateTime;
  @override
  set dueDate(DateTime value) => RealmObjectBase.set(this, 'dueDate', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  String get frequencyString =>
      RealmObjectBase.get<String>(this, 'frequencyString') as String;
  @override
  set frequencyString(String value) =>
      RealmObjectBase.set(this, 'frequencyString', value);

  @override
  String get rememberString =>
      RealmObjectBase.get<String>(this, 'rememberString') as String;
  @override
  set rememberString(String value) =>
      RealmObjectBase.set(this, 'rememberString', value);

  @override
  RealmList<String> get expenseIdList =>
      RealmObjectBase.get<String>(this, 'expenseIdList') as RealmList<String>;
  @override
  set expenseIdList(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  ExpenseCategoryModel? get category =>
      RealmObjectBase.get<ExpenseCategoryModel>(this, 'category')
          as ExpenseCategoryModel?;
  @override
  set category(covariant ExpenseCategoryModel? value) =>
      RealmObjectBase.set(this, 'category', value);

  @override
  Stream<RealmObjectChanges<FixedExpenseModel>> get changes =>
      RealmObjectBase.getChanges<FixedExpenseModel>(this);

  @override
  Stream<RealmObjectChanges<FixedExpenseModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<FixedExpenseModel>(this, keyPaths);

  @override
  FixedExpenseModel freeze() =>
      RealmObjectBase.freezeObject<FixedExpenseModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'dueDate': dueDate.toEJson(),
      'description': description.toEJson(),
      'amount': amount.toEJson(),
      'frequencyString': frequencyString.toEJson(),
      'rememberString': rememberString.toEJson(),
      'expenseIdList': expenseIdList.toEJson(),
      'category': category.toEJson(),
    };
  }

  static EJsonValue _toEJson(FixedExpenseModel value) => value.toEJson();
  static FixedExpenseModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'dueDate': EJsonValue dueDate,
        'description': EJsonValue description,
        'amount': EJsonValue amount,
        'frequencyString': EJsonValue frequencyString,
        'rememberString': EJsonValue rememberString,
      } =>
        FixedExpenseModel(
          fromEJson(id),
          fromEJson(dueDate),
          fromEJson(description),
          fromEJson(amount),
          fromEJson(frequencyString),
          fromEJson(rememberString),
          expenseIdList: fromEJson(ejson['expenseIdList']),
          category: fromEJson(ejson['category']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FixedExpenseModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, FixedExpenseModel, 'FixedExpenseModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('dueDate', RealmPropertyType.timestamp),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('frequencyString', RealmPropertyType.string),
      SchemaProperty('rememberString', RealmPropertyType.string),
      SchemaProperty('expenseIdList', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'ExpenseCategoryModel'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class IncomeModel extends _IncomeModel
    with RealmEntity, RealmObjectBase, RealmObject {
  IncomeModel(
    String id,
    double amount,
    DateTime date,
    String description, {
    IncomeSourceModel? source,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'source', source);
  }

  IncomeModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  IncomeSourceModel? get source =>
      RealmObjectBase.get<IncomeSourceModel>(this, 'source')
          as IncomeSourceModel?;
  @override
  set source(covariant IncomeSourceModel? value) =>
      RealmObjectBase.set(this, 'source', value);

  @override
  Stream<RealmObjectChanges<IncomeModel>> get changes =>
      RealmObjectBase.getChanges<IncomeModel>(this);

  @override
  Stream<RealmObjectChanges<IncomeModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<IncomeModel>(this, keyPaths);

  @override
  IncomeModel freeze() => RealmObjectBase.freezeObject<IncomeModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'amount': amount.toEJson(),
      'date': date.toEJson(),
      'description': description.toEJson(),
      'source': source.toEJson(),
    };
  }

  static EJsonValue _toEJson(IncomeModel value) => value.toEJson();
  static IncomeModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'amount': EJsonValue amount,
        'date': EJsonValue date,
        'description': EJsonValue description,
      } =>
        IncomeModel(
          fromEJson(id),
          fromEJson(amount),
          fromEJson(date),
          fromEJson(description),
          source: fromEJson(ejson['source']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(IncomeModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, IncomeModel, 'IncomeModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('source', RealmPropertyType.object,
          optional: true, linkTarget: 'IncomeSourceModel'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class IncomeSourceModel extends _IncomeSourceModel
    with RealmEntity, RealmObjectBase, RealmObject {
  IncomeSourceModel(
    String id,
    String name,
    int _colorValue,
    int _iconValue, {
    Iterable<IncomeModel> incomes = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'color', _colorValue);
    RealmObjectBase.set(this, 'icon', _iconValue);
    RealmObjectBase.set<RealmList<IncomeModel>>(
        this, 'incomes', RealmList<IncomeModel>(incomes));
  }

  IncomeSourceModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get _colorValue => RealmObjectBase.get<int>(this, 'color') as int;
  @override
  set _colorValue(int value) => RealmObjectBase.set(this, 'color', value);

  @override
  int get _iconValue => RealmObjectBase.get<int>(this, 'icon') as int;
  @override
  set _iconValue(int value) => RealmObjectBase.set(this, 'icon', value);

  @override
  RealmList<IncomeModel> get incomes =>
      RealmObjectBase.get<IncomeModel>(this, 'incomes')
          as RealmList<IncomeModel>;
  @override
  set incomes(covariant RealmList<IncomeModel> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<IncomeSourceModel>> get changes =>
      RealmObjectBase.getChanges<IncomeSourceModel>(this);

  @override
  Stream<RealmObjectChanges<IncomeSourceModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<IncomeSourceModel>(this, keyPaths);

  @override
  IncomeSourceModel freeze() =>
      RealmObjectBase.freezeObject<IncomeSourceModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'color': _colorValue.toEJson(),
      'icon': _iconValue.toEJson(),
      'incomes': incomes.toEJson(),
    };
  }

  static EJsonValue _toEJson(IncomeSourceModel value) => value.toEJson();
  static IncomeSourceModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'color': EJsonValue _colorValue,
        'icon': EJsonValue _iconValue,
      } =>
        IncomeSourceModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(_colorValue),
          fromEJson(_iconValue),
          incomes: fromEJson(ejson['incomes']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(IncomeSourceModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, IncomeSourceModel, 'IncomeSourceModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('_colorValue', RealmPropertyType.int, mapTo: 'color'),
      SchemaProperty('_iconValue', RealmPropertyType.int, mapTo: 'icon'),
      SchemaProperty('incomes', RealmPropertyType.object,
          linkTarget: 'IncomeModel', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class UserModel extends _UserModel
    with RealmEntity, RealmObjectBase, RealmObject {
  UserModel(
    String id,
    String name,
    String email,
    String password,
    double balance,
    bool hasOnboarding,
    int _themeValue, {
    String? notificationToken,
    String? authId,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'balance', balance);
    RealmObjectBase.set(this, 'notificationToken', notificationToken);
    RealmObjectBase.set(this, 'hasOnboarding', hasOnboarding);
    RealmObjectBase.set(this, 'authId', authId);
    RealmObjectBase.set(this, 'theme', _themeValue);
  }

  UserModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get password =>
      RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  double get balance => RealmObjectBase.get<double>(this, 'balance') as double;
  @override
  set balance(double value) => RealmObjectBase.set(this, 'balance', value);

  @override
  String? get notificationToken =>
      RealmObjectBase.get<String>(this, 'notificationToken') as String?;
  @override
  set notificationToken(String? value) =>
      RealmObjectBase.set(this, 'notificationToken', value);

  @override
  bool get hasOnboarding =>
      RealmObjectBase.get<bool>(this, 'hasOnboarding') as bool;
  @override
  set hasOnboarding(bool value) =>
      RealmObjectBase.set(this, 'hasOnboarding', value);

  @override
  String? get authId => RealmObjectBase.get<String>(this, 'authId') as String?;
  @override
  set authId(String? value) => RealmObjectBase.set(this, 'authId', value);

  @override
  int get _themeValue => RealmObjectBase.get<int>(this, 'theme') as int;
  @override
  set _themeValue(int value) => RealmObjectBase.set(this, 'theme', value);

  @override
  Stream<RealmObjectChanges<UserModel>> get changes =>
      RealmObjectBase.getChanges<UserModel>(this);

  @override
  Stream<RealmObjectChanges<UserModel>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<UserModel>(this, keyPaths);

  @override
  UserModel freeze() => RealmObjectBase.freezeObject<UserModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'email': email.toEJson(),
      'password': password.toEJson(),
      'balance': balance.toEJson(),
      'notificationToken': notificationToken.toEJson(),
      'hasOnboarding': hasOnboarding.toEJson(),
      'authId': authId.toEJson(),
      'theme': _themeValue.toEJson(),
    };
  }

  static EJsonValue _toEJson(UserModel value) => value.toEJson();
  static UserModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'email': EJsonValue email,
        'password': EJsonValue password,
        'balance': EJsonValue balance,
        'hasOnboarding': EJsonValue hasOnboarding,
        'theme': EJsonValue _themeValue,
      } =>
        UserModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(email),
          fromEJson(password),
          fromEJson(balance),
          fromEJson(hasOnboarding),
          fromEJson(_themeValue),
          notificationToken: fromEJson(ejson['notificationToken']),
          authId: fromEJson(ejson['authId']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(UserModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, UserModel, 'UserModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('balance', RealmPropertyType.double),
      SchemaProperty('notificationToken', RealmPropertyType.string,
          optional: true),
      SchemaProperty('hasOnboarding', RealmPropertyType.bool),
      SchemaProperty('authId', RealmPropertyType.string, optional: true),
      SchemaProperty('_themeValue', RealmPropertyType.int, mapTo: 'theme'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
