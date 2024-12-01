import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:realm/realm.dart';

part 'income_model.realm.dart';

@RealmModel()
class _IncomeModel {
  @PrimaryKey()
  late String id;
  late double amount;
  late DateTime date;
  late String description;
  late String sourceString;

  IncomeSource get source => IncomeSource.values
      .firstWhere((e) => e.toString().split('.').last == sourceString);

  set source(IncomeSource source) {
    sourceString = source.toString().split('.').last;
  }
}
