import 'package:my_kakeibo/data/repository/realm/model/models.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

final realmSchemas = [
  UserModel.schema,
  IncomeModel.schema,
  ExpenseModel.schema,
  FixedExpenseModel.schema,
  ExpenseCategoryModel.schema,
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
      initialDataCallback: (realm) {
        realm.add(
          ExpenseCategoryModel(uuid.v4(), "misc", 0, 0),
        );
        realm.add(
          ExpenseCategoryModel(uuid.v4(), "dog", 1, 1),
        );
        realm.add(
          ExpenseCategoryModel(uuid.v4(), "home", 2, 2),
        );
        realm.add(
          ExpenseCategoryModel(uuid.v4(), "book", 3, 3),
        );
        realm.add(
          ExpenseCategoryModel(uuid.v4(), "food", 4, 4),
        );
      },
    );
    realm = Realm(config);
  }
}
