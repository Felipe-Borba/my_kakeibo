part of 'models.dart';

@RealmModel()
class _IncomeModel {
  @PrimaryKey()
  late String id;

  late double amount;

  late DateTime date;

  late String description;

  late _IncomeSourceModel? source;
}
