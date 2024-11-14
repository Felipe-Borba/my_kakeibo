import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';

class FixedExpense {
  String? id;
  List<Expense> expenseList;
  DateTime dueDate;
  String description;
  Frequency frequency;
  Remember remember;
  ExpenseCategory category;
  double amount;

  FixedExpense({
    this.id,
    required this.amount,
    required this.expenseList,
    required this.dueDate,
    required this.description,
    required this.frequency,
    required this.remember,
    required this.category,
  });

  factory FixedExpense.fromJson(Map<String, dynamic> json) {
    return FixedExpense(
      id: json["id"],
      amount: (json["amount"] as num).toDouble(),
      dueDate: json["dueDate"],
      description: json["description"],
      category: json['category'],
      expenseList: json['add lib'],
      frequency: json['todo'],
      remember: json['todo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'dueDate': dueDate,
      'description': description,
    };
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
