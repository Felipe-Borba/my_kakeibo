// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Income _$IncomeFromJson(Map<String, dynamic> json) => Income(
      id: json['id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      source: $enumDecode(_$IncomeSourceEnumMap, json['source']),
    );

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'source': _$IncomeSourceEnumMap[instance.source]!,
    };

const _$IncomeSourceEnumMap = {
  IncomeSource.salary: 'salary',
};
