import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:realm/realm.dart';

part 'fixed_expense_model.realm.dart';

@RealmModel()
class _FixedExpenseModel {
  @PrimaryKey()
  late String id;
  late List<String> expenseIdList;
  late DateTime dueDate;
  late String description;
  late String frequencyString;
  late String rememberString;
  late String categoryString;
  late double amount;

  ExpenseCategory get category =>
      ExpenseCategory.values.getByDescription(categoryString);

  set category(ExpenseCategory category) {
    categoryString = category.description;
  }

  Frequency get frequency => Frequency.values.getByDescription(frequencyString);
  set frequency(Frequency frequency) {
    frequencyString = frequency.description;
  }

  Remember get remember => Remember.values.getByDescription(rememberString);

  set remember(Remember remember) {
    rememberString = remember.description;
  }
}
