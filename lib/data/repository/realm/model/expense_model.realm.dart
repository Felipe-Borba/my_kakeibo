// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ExpenseModel extends _ExpenseModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ExpenseModel(
    String id,
    double amount,
    DateTime date,
    String description,
    String categoryString,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'categoryString', categoryString);
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
  String get categoryString =>
      RealmObjectBase.get<String>(this, 'categoryString') as String;
  @override
  set categoryString(String value) =>
      RealmObjectBase.set(this, 'categoryString', value);

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
      'categoryString': categoryString.toEJson(),
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
        'categoryString': EJsonValue categoryString,
      } =>
        ExpenseModel(
          fromEJson(id),
          fromEJson(amount),
          fromEJson(date),
          fromEJson(description),
          fromEJson(categoryString),
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
      SchemaProperty('categoryString', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
