import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Expense extends Transaction {
  // TODO depois no futuro seria legal deixar o usuário criar isso
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
}

enum ExpenseCategory {
  misc,
  rent,
  food,
  entertainment,
}
