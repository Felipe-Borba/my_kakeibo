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
    super.userId,
  });

  Income copyWith({
    String? id,
    double? amount,
    DateTime? date,
    String? description,
    IncomeSource? source,
    String? userId,
  }) {
    return Income(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      source: source ?? this.source,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'income_id': id,
      'income_amount': amount,
      'income_date': date.toIso8601String(),
      'income_description': description,
      'income_source_id': source.id,
      'user_id': userId,
    };
  }

  factory Income.fromMap(Map<String, dynamic> map, IncomeSource source) {
    return Income(
      id: map['income_id'],
      amount: map['income_amount'],
      date: DateTime.parse(map['income_date']),
      description: map['income_description'],
      source: source,
      userId: map['user_id'],
    );
  }
}
