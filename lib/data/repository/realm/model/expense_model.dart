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

  ExpenseCategory get category => ExpenseCategory.values
      .firstWhere((e) => e.toString().split('.').last == categoryString);

  set category(ExpenseCategory category) {
    categoryString = category.toString().split('.').last;
  }//TODO ao invéz de ter isso espalhado posso vazer um rolezinho com extention lá no enum
}
