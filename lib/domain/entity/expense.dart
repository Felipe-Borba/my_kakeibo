import 'package:my_kakeibo/domain/entity/transaction.dart';

class Expense extends Transaction {
  // ExpenseCategory category; //aluguel, conta etc,
  // String payee // quem recebeu
  // PaymentMethod paymentMethod;

  // algumas despesas são dedutíveis como saúde e educação no BR.

  Expense({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
  });
}
