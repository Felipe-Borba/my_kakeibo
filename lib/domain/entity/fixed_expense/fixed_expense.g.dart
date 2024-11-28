// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixedExpense _$FixedExpenseFromJson(Map<String, dynamic> json) => FixedExpense(
      id: json['id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      expenseIdList: (json['expenseIdList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      description: json['description'] as String,
      frequency: $enumDecode(_$FrequencyEnumMap, json['frequency']),
      remember: $enumDecode(_$RememberEnumMap, json['remember']),
      category: $enumDecode(_$ExpenseCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$FixedExpenseToJson(FixedExpense instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expenseIdList': instance.expenseIdList,
      'dueDate': instance.dueDate.toIso8601String(),
      'description': instance.description,
      'frequency': _$FrequencyEnumMap[instance.frequency]!,
      'remember': _$RememberEnumMap[instance.remember]!,
      'category': _$ExpenseCategoryEnumMap[instance.category]!,
      'amount': instance.amount,
    };

const _$FrequencyEnumMap = {
  Frequency.daily: 'daily',
  Frequency.weekly: 'weekly',
  Frequency.monthly: 'monthly',
  Frequency.annually: 'annually',
};

const _$RememberEnumMap = {
  Remember.no: 'no',
  Remember.weekBefore: 'weekBefore',
  Remember.dayBefore: 'dayBefore',
  Remember.atDueDate: 'atDueDate',
};

const _$ExpenseCategoryEnumMap = {
  ExpenseCategory.misc: 'misc',
  ExpenseCategory.rent: 'rent',
  ExpenseCategory.food: 'food',
  ExpenseCategory.entertainment: 'entertainment',
};
