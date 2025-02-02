import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

final realmSchemas = [
  UserModel.schema,
  IncomeModel.schema,
  ExpenseModel.schema,
  FixedExpenseModel.schema,
  ExpenseCategoryModel.schema,
  IncomeSourceModel.schema,
];

class RealmConfig {
  static final RealmConfig _instance = RealmConfig._internal();
  late final Realm realm;
  late final Uuid uuid;

  factory RealmConfig() {
    return _instance;
  }

  RealmConfig._internal() {
    uuid = const Uuid();
    final config = Configuration.local(
      realmSchemas,
      schemaVersion: 1,
      shouldDeleteIfMigrationNeeded: true, //TODO enquanto o app está em alfa
    );
    realm = Realm(config);
  }
}
