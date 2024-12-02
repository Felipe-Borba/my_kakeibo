import 'package:my_kakeibo/data/repository/realm/model/expense_model.dart';
import 'package:my_kakeibo/data/repository/realm/model/fixed_expense_model.dart';
import 'package:my_kakeibo/data/repository/realm/model/income_model.dart';
import 'package:my_kakeibo/data/repository/realm/model/user_model.dart';
import 'package:realm/realm.dart';

final realmSchemas = [
  UserModel.schema,
  IncomeModel.schema,
  ExpenseModel.schema,
  FixedExpenseModel.schema,
];
final config = Configuration.inMemory(realmSchemas); //TODO retornar para local

//TODO seria mais inteligente ter injetado esse basculho do que ter criado um singleton pq fica mais dibas de trocar de local para in memory nos testes
class RealmService {
  static Realm? _realm;

  static Realm get instance {
    _realm ??= Realm(config);
    return _realm!;
  }

  RealmService._();
}
