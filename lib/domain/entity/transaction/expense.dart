import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Expense extends Transaction {
  ExpenseCategory category; //aluguel, conta etc,
  // String payee // quem recebeu
  // PaymentMethod paymentMethod;

  // algumas despesas são dedutíveis como saúde e educação no BR.

  Expense({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.category,
  });

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'sourceId': category.id,
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

