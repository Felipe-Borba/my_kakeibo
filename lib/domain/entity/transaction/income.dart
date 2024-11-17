import 'package:json_annotation/json_annotation.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';

part 'income.g.dart';

@JsonSerializable()
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

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeToJson(this);
}
