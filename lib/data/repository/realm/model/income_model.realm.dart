// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class IncomeModel extends _IncomeModel
    with RealmEntity, RealmObjectBase, RealmObject {
  IncomeModel(
    String id,
    double amount,
    DateTime date,
    String description,
    String sourceString,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'sourceString', sourceString);
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
  String get sourceString =>
      RealmObjectBase.get<String>(this, 'sourceString') as String;
  @override
  set sourceString(String value) =>
      RealmObjectBase.set(this, 'sourceString', value);

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
      'sourceString': sourceString.toEJson(),
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
        'sourceString': EJsonValue sourceString,
      } =>
        IncomeModel(
          fromEJson(id),
          fromEJson(amount),
          fromEJson(date),
          fromEJson(description),
          fromEJson(sourceString),
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
      SchemaProperty('sourceString', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
