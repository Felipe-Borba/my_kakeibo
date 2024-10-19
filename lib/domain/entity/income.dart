import 'package:my_kakeibo/domain/entity/transaction.dart';

class Income extends Transaction {
  // IncomeCategory category; não sei se faz sentido isso aqui perguntar pai
  // IncomeSource source; // salario, investimento, etc.
  // Tax Withholdings

  // da mesma forma que lá na despesa aqui seria um tipo de receita?
  // receitas normalmente são cobradas imposto sobre

  Income({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
  });
}
