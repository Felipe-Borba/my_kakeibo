import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';

class FixedExpense {
  final String? id;
  final List<Expense> expenseList;
  final DateTime dueDate;
  final String description;
  final Frequency frequency;
  final Remember remember;
  final ExpenseCategory category;
  final double amount;
  final String? userId;
  final int? notificationId;

  FixedExpense({
    this.id,
    required this.amount,
    required this.expenseList,
    required this.dueDate,
    required this.description,
    required this.frequency,
    required this.remember,
    required this.category,
    this.userId,
    this.notificationId,
  });

  FixedExpense pay(Expense expense) {
    expenseList.add(expense);

    DateTime dueDate = switch (frequency) {
      Frequency.daily => this.dueDate.add(const Duration(days: 1)),
      Frequency.weekly => this.dueDate.add(const Duration(days: 7)),
      Frequency.monthly => _addMonth(this.dueDate),
      Frequency.annually => _addYear(this.dueDate),
    };

    return copyWith(
      expenseList: List.from(expenseList),
      dueDate: dueDate,
    );
  }

  DateTime _addMonth(DateTime data) {
    int novoMes = data.month + 1;
    int novoAno = data.year;

    if (novoMes > 12) {
      novoMes = 1;
      novoAno += 1;
    }

    int ultimoDiaDoMes = DateTime(novoAno, novoMes + 1, 0).day;
    int novoDia = data.day > ultimoDiaDoMes ? ultimoDiaDoMes : data.day;

    return DateTime(novoAno, novoMes, novoDia);
  }

  DateTime _addYear(DateTime data) {
    int novoAno = data.year + 1;

    int ultimoDiaDoMes = DateTime(novoAno, data.month + 1, 0).day;
    int novoDia = data.day > ultimoDiaDoMes ? ultimoDiaDoMes : data.day;

    return DateTime(novoAno, data.month, novoDia);
  }

  FixedExpense copyWith({
    String? id,
    List<Expense>? expenseList,
    DateTime? dueDate,
    String? description,
    Frequency? frequency,
    Remember? remember,
    ExpenseCategory? category,
    double? amount,
    String? userId,
    int? notificationId,
  }) {
    return FixedExpense(
      id: id ?? this.id,
      expenseList: expenseList ?? this.expenseList,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      remember: remember ?? this.remember,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
      notificationId: notificationId ?? this.notificationId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fixed_expense_id': id,
      'fixed_expense_amount': amount,
      'fixed_expense_due_date': dueDate.toIso8601String(),
      'fixed_expense_description': description,
      'fixed_expense_frequency': frequency.index,
      'fixed_expense_remember': remember.index,
      'expense_category_id': category.id,
      'user_id': userId,
      'notification_id': notificationId,
    };
  }

  factory FixedExpense.fromMap(
    Map<String, dynamic> map,
    ExpenseCategory category,
    List<Expense> expenseList,
  ) {
    return FixedExpense(
      id: map['fixed_expense_id'],
      amount: map['fixed_expense_amount'],
      dueDate: DateTime.parse(map['fixed_expense_due_date']),
      description: map['fixed_expense_description'],
      frequency: Frequency.values[map['fixed_expense_frequency']],
      remember: Remember.values[map['fixed_expense_remember']],
      expenseList: expenseList,
      category: category,
      userId: map['user_id'],
      notificationId: map['notification_id'] != null
          ? int.tryParse(map['notification_id'].toString())
          : null,
    );
  }
}
