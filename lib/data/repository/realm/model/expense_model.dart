import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:realm/realm.dart';

part 'expense_model.realm.dart';

@RealmModel()
class _ExpenseModel {
  @PrimaryKey()
  late String id;
  late double amount;
  late DateTime date;
  late String description;
  late String categoryString;

  ExpenseCategory get category =>
      ExpenseCategory.values.getByDescription(categoryString);

  set category(ExpenseCategory category) {
    categoryString = category.description;
  }
}
