import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:uuid/uuid.dart';

class FixedExpenseModel {
  String id;
  List<String> expenseIdList;
  Timestamp dueDate;
  String description;
  late String frequencyString;
  late String rememberString;
  late String categoryString;
  double amount;

  FixedExpenseModel({
    required this.id,
    required this.amount,
    required this.expenseIdList,
    required this.dueDate,
    required this.description,
  });

  ExpenseCategory get category => ExpenseCategory.values
      .firstWhere((e) => e.toString().split('.').last == categoryString);
  set category(ExpenseCategory category) {
    categoryString = category.toString().split('.').last;
  }

  Frequency get frequency => Frequency.values
      .firstWhere((e) => e.toString().split('.').last == frequencyString);
  set frequency(Frequency frequency) {
    frequencyString = frequency.toString().split('.').last;
  }

  Remember get remember => Remember.values
      .firstWhere((e) => e.toString().split('.').last == rememberString);
  set remember(Remember remember) {
    rememberString = remember.toString().split('.').last;
  }

  factory FixedExpenseModel.fromEntity(FixedExpense entity) {
    const uuid = Uuid();
    var model = FixedExpenseModel(
      id: entity.id ?? uuid.v4(),
      amount: entity.amount,
      dueDate: Timestamp.fromDate(entity.dueDate),
      description: entity.description,
      expenseIdList: entity.expenseIdList,
    );
    model.category = entity.category;
    model.remember = entity.remember;
    model.frequency = entity.frequency;
    return model;
  }

  factory FixedExpenseModel.fromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    var data = doc.data();
    var model = FixedExpenseModel(
      id: doc.id,
      amount: data["amount"],
      dueDate: data['dueDate'],
      description: data["description"],
      expenseIdList: (data['expenseIdList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
    model.categoryString = data["category"];
    model.rememberString = data["remember"];
    model.frequencyString = data["frequency"];
    return model;
  }

  FixedExpense toEntity() {
    return FixedExpense(
      id: id,
      amount: amount,
      dueDate: dueDate.toDate(),
      description: description,
      category: category,
      frequency: frequency,
      expenseIdList: expenseIdList,
      remember: remember,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'dueDate': dueDate,
      'description': description,
      'category': categoryString,
      'frequency': frequencyString,
      'expenseIdList': expenseIdList,
      'remember': rememberString,
    };
  }
}

//formJson -> frequency: $enumDecode(_$FrequencyEnumMap, json['frequency']),
//toJson -> 'frequency': _$FrequencyEnumMap[instance.frequency]!,
// const _$FrequencyEnumMap = {
//   Frequency.daily: 'daily',
//   Frequency.weekly: 'weekly',
//   Frequency.monthly: 'monthly',
//   Frequency.annually: 'annually',
// };