part of 'models.dart';

@RealmModel()
class _IncomeModel {
  @PrimaryKey()
  late String id;

  late double amount;

  late DateTime date;

  late String description;

  late String sourceString;
  IncomeSource get source => IncomeSource.values.getByDescription(sourceString);
  set source(IncomeSource source) => sourceString = source.description;
}
