import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:uuid/uuid.dart';

class ExpenseModel {
  String id;
  double amount;
  Timestamp date;
  String description;
  late String categoryString;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
  });

  ExpenseCategory get category => ExpenseCategory.values
      .firstWhere((e) => e.toString().split('.').last == categoryString);

  set category(ExpenseCategory category) {
    categoryString = category.toString().split('.').last;
  }

  factory ExpenseModel.fromExpense(Expense expense) {
    const uuid = Uuid();
    var model = ExpenseModel(
      id: expense.id ?? uuid.v4(),
      amount: expense.amount,
      date: Timestamp.fromDate(expense.date),
      description: expense.description,
    );
    model.category = expense.category;
    return model;
  }

  factory ExpenseModel.fromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    var data = doc.data();
    var model = ExpenseModel(
      id: doc.id,
      amount: data["amount"],
      date: data['date'],
      description: data["description"],
    );
    model.categoryString = data["category"];
    return model;
  }

  Expense toEntity() {
    return Expense(
      id: id,
      amount: amount,
      date: date.toDate(),
      description: description,
      category: category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'description': description,
      'category': categoryString,
    };
  }
}
