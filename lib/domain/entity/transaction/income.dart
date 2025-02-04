import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'sourceId': source.id,
    };
  }

  factory Income.fromMap(Map<String, dynamic> map, IncomeSource source) {
    return Income(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      source: source,
    );
  }
}
