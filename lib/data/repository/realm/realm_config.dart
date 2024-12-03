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
final config = Configuration.local(realmSchemas);
