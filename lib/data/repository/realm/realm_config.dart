import 'package:my_kakeibo/data/repository/realm/model/expense_model.dart';
import 'package:my_kakeibo/data/repository/realm/model/fixed_expense_model.dart';
import 'package:my_kakeibo/data/repository/realm/model/income_model.dart';
import 'package:my_kakeibo/data/repository/realm/model/user_model.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

final realmSchemas = [
  UserModel.schema,
  IncomeModel.schema,
  ExpenseModel.schema,
  FixedExpenseModel.schema,
];
final config = Configuration.local(
  realmSchemas,
  shouldDeleteIfMigrationNeeded: true, //TODO enquanto o app está em alfa
);

class RealmConfig {
  static final RealmConfig _instance = RealmConfig._internal();
  late final Realm realm;
  late final uuid;

  factory RealmConfig() {
    return _instance;
  }

  RealmConfig._internal() {
    realm = Realm(config);
    uuid = const Uuid();
  }
}

