import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Income extends Transaction {
  IncomeSource source;
  // Tax Withholdings

  Income({
    required super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.source,
  });
}

enum IncomeSource {
  salary,
}
