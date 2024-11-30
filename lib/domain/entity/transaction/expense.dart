import 'package:json_annotation/json_annotation.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

part 'expense.g.dart';

@JsonSerializable()
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

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}

enum ExpenseCategory {
  misc,
  rent,
  food,
  entertainment,
}
