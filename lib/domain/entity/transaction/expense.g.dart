// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      id: json['id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      category: $enumDecode(_$ExpenseCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'category': _$ExpenseCategoryEnumMap[instance.category]!,
    };

const _$ExpenseCategoryEnumMap = {
  ExpenseCategory.misc: 'misc',
  ExpenseCategory.rent: 'rent',
  ExpenseCategory.food: 'food',
  ExpenseCategory.entertainment: 'entertainment',
};
