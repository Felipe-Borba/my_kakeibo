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

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json["id"],
      amount: (json["amount"] as num).toDouble(),
      date: json["date"],
      description: json["description"],
      source: mapExpenseSource(json["source"].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'description': description,
      'source': source.name,
    };
  }
}
