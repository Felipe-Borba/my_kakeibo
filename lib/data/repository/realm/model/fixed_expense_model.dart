part of 'models.dart';

@RealmModel()
class _FixedExpenseModel {
  @PrimaryKey()
  late String id;

  late DateTime dueDate;

  late String description;

  late double amount;

  late String frequencyString;
  Frequency get frequency => Frequency.values.getByDescription(frequencyString);
  set frequency(Frequency frequency) => frequencyString = frequency.description;

  late String rememberString;
  Remember get remember => Remember.values.getByDescription(rememberString);
  set remember(Remember remember) => rememberString = remember.description;

  late List<String> expenseIdList;

  late _ExpenseCategoryModel? category;
}
