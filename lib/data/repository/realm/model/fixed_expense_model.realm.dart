// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_expense_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FixedExpenseModel extends _FixedExpenseModel
    with RealmEntity, RealmObjectBase, RealmObject {
  FixedExpenseModel(
    String id,
    DateTime dueDate,
    String description,
    String frequencyString,
    String rememberString,
    String categoryString,
    double amount, {
    Iterable<String> expenseIdList = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set<RealmList<String>>(
        this, 'expenseIdList', RealmList<String>(expenseIdList));
    RealmObjectBase.set(this, 'dueDate', dueDate);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'frequencyString', frequencyString);
    RealmObjectBase.set(this, 'rememberString', rememberString);
    RealmObjectBase.set(this, 'categoryString', categoryString);
    RealmObjectBase.set(this, 'amount', amount);
  }

  FixedExpenseModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  RealmList<String> get expenseIdList =>
      RealmObjectBase.get<String>(this, 'expenseIdList') as RealmList<String>;
  @override
  set expenseIdList(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

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
  String get categoryString =>
      RealmObjectBase.get<String>(this, 'categoryString') as String;
  @override
  set categoryString(String value) =>
      RealmObjectBase.set(this, 'categoryString', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

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
      'expenseIdList': expenseIdList.toEJson(),
      'dueDate': dueDate.toEJson(),
      'description': description.toEJson(),
      'frequencyString': frequencyString.toEJson(),
      'rememberString': rememberString.toEJson(),
      'categoryString': categoryString.toEJson(),
      'amount': amount.toEJson(),
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
        'frequencyString': EJsonValue frequencyString,
        'rememberString': EJsonValue rememberString,
        'categoryString': EJsonValue categoryString,
        'amount': EJsonValue amount,
      } =>
        FixedExpenseModel(
          fromEJson(id),
          fromEJson(dueDate),
          fromEJson(description),
          fromEJson(frequencyString),
          fromEJson(rememberString),
          fromEJson(categoryString),
          fromEJson(amount),
          expenseIdList: fromEJson(ejson['expenseIdList']),
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
      SchemaProperty('expenseIdList', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('dueDate', RealmPropertyType.timestamp),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('frequencyString', RealmPropertyType.string),
      SchemaProperty('rememberString', RealmPropertyType.string),
      SchemaProperty('categoryString', RealmPropertyType.string),
      SchemaProperty('amount', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
