import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

class Income extends Transaction {
  IncomeSource source;

  Income({
    super.id,
    required super.amount,
    required super.date,
    required super.description,
    required this.source,
  });

  Income copyWith({
    String? id,
    double? amount,
    DateTime? date,
    String? description,
    IncomeSource? source,
  }) {
    return Income(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      source: source ?? this.source,
    );
  }

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
