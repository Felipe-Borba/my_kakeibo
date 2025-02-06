import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Expense extends Transaction {
  final ExpenseCategory category;

  Expense({
    super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.category,
  });

  Expense copyWith({
    String? id,
    double? amount,
    DateTime? date,
    String? description,
    ExpenseCategory? category,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'categoryId': category.id,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map, ExpenseCategory category) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      category: category,
    );
  }
}
