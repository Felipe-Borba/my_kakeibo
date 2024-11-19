import 'package:json_annotation/json_annotation.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';

part 'fixed_expense.g.dart';

@JsonSerializable()
class FixedExpense {
  String? id;
  List<String> expenseIdList;
  DateTime dueDate;
  String description;
  Frequency frequency;
  Remember remember;
  ExpenseCategory category;
  double amount;

  FixedExpense({
    this.id,
    required this.amount,
    required this.expenseIdList,
    required this.dueDate,
    required this.description,
    required this.frequency,
    required this.remember,
    required this.category,
  });

  factory FixedExpense.fromJson(Map<String, dynamic> json) =>
      _$FixedExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$FixedExpenseToJson(this);

  void pay(Expense expense) {
    if (expense.id != null) {
      expenseIdList.add(expense.id!);
    }
  }
}

enum Frequency {
  daily,
  weekly,
  monthly,
  annually,
}

enum Remember {
  no,
  weekBefore,
  dayBefore,
  atDueDate,
}
