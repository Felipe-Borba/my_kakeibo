part of 'models.dart';

@RealmModel()
class _ExpenseModel {
  @PrimaryKey()
  late String id;

  late double amount;

  late DateTime date;

  late String description;

  late _ExpenseCategoryModel? category;
}
