import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:uuid/uuid.dart';

class IncomeModel {
  String id;
  double amount;
  Timestamp date;
  String description;
  late String sourceString;

  IncomeModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
  });

  IncomeSource get source => IncomeSource.values
      .firstWhere((e) => e.toString().split('.').last == sourceString);

  set source(IncomeSource source) {
    sourceString = source.toString().split('.').last;
  }

  factory IncomeModel.fromEntity(Income income) {
    const uuid = Uuid();
    var model = IncomeModel(
      id: income.id ?? uuid.v4(),
      amount: income.amount,
      date: Timestamp.fromDate(income.date),
      description: income.description,
    );
    model.source = income.source;
    return model;
  }

  factory IncomeModel.fromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    var data = doc.data();
    var model = IncomeModel(
      id: doc.id,
      amount: data["amount"],
      date: data['date'],
      description: data["description"],
    );
    model.sourceString = data["source"];
    return model;
  }

  Income toEntity() {
    return Income(
      id: id,
      amount: amount,
      date: date.toDate(),
      description: description,
      source: source,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'description': description,
      'source': sourceString,
    };
  }
}
