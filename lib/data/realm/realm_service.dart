import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

class RealmService {
  late final Realm realm;
  static const _uuid = Uuid();

  final _realmSchemas = [
    UserModel.schema,
    IncomeModel.schema,
    ExpenseModel.schema,
    FixedExpenseModel.schema,
    ExpenseCategoryModel.schema,
    IncomeSourceModel.schema,
  ];

  RealmService({bool test = false}) {
    if (test) {
      realm = Realm(Configuration.local(
        _realmSchemas,
        path: "./test/data/realm/realm.db",
        shouldDeleteIfMigrationNeeded: true,
      ));
    } else {
      realm = Realm(Configuration.local(
        _realmSchemas,
        schemaVersion: 1,
        shouldDeleteIfMigrationNeeded: true, //TODO enquanto o app está em alfa
      ));
    }
  }

  static String generateUuid() => _uuid.v4();
}
