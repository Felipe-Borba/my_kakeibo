// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserModel extends _UserModel
    with RealmEntity, RealmObjectBase, RealmObject {
  UserModel(
    String id,
    String name,
    String email,
    String password,
    double balance,
    bool hasOnboarding, {
    String? themeString,
    String? notificationToken,
    String? authId,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'themeString', themeString);
    RealmObjectBase.set(this, 'balance', balance);
    RealmObjectBase.set(this, 'notificationToken', notificationToken);
    RealmObjectBase.set(this, 'hasOnboarding', hasOnboarding);
    RealmObjectBase.set(this, 'authId', authId);
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
  String? get themeString =>
      RealmObjectBase.get<String>(this, 'themeString') as String?;
  @override
  set themeString(String? value) =>
      RealmObjectBase.set(this, 'themeString', value);

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
      'themeString': themeString.toEJson(),
      'balance': balance.toEJson(),
      'notificationToken': notificationToken.toEJson(),
      'hasOnboarding': hasOnboarding.toEJson(),
      'authId': authId.toEJson(),
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
      } =>
        UserModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(email),
          fromEJson(password),
          fromEJson(balance),
          fromEJson(hasOnboarding),
          themeString: fromEJson(ejson['themeString']),
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
      SchemaProperty('themeString', RealmPropertyType.string, optional: true),
      SchemaProperty('balance', RealmPropertyType.double),
      SchemaProperty('notificationToken', RealmPropertyType.string,
          optional: true),
      SchemaProperty('hasOnboarding', RealmPropertyType.bool),
      SchemaProperty('authId', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
