import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Expense extends Transaction {
  final ExpenseCategory category;
  final FixedExpense? fixedExpense;

  Expense({
    super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.category,
    this.fixedExpense,
    super.userId,
  });

  Expense copyWith({
    String? id,
    double? amount,
    DateTime? date,
    String? description,
    ExpenseCategory? category,
    FixedExpense? fixedExpense,
    String? userId,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
      fixedExpense: fixedExpense ?? this.fixedExpense,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_id': id,
      'expense_amount': amount,
      'expense_date': date.toIso8601String(),
      'expense_description': description,
      'expense_category_id': category.id,
      'fixed_expense_id': fixedExpense?.id,
      'user_id': userId,
    };
  }

  factory Expense.fromMap(
    Map<String, dynamic> map,
    ExpenseCategory category,
    FixedExpense? fixedExpense,
  ) {
    return Expense(
      id: map['expense_id'],
      amount: map['expense_amount'],
      date: DateTime.parse(map['expense_date']),
      description: map['expense_description'],
      category: category,
      fixedExpense: fixedExpense,
      userId: map['user_id'],
    );
  }
}
