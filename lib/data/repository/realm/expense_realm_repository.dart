import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/realm/model/expense_model.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

class ExpenseRealmRepository extends ExpenseRepository {
  final Realm realm;
  final Uuid uuid; //TODO preciso disso mesmo?

  ExpenseRealmRepository(this.realm, this.uuid);

  @override
  Future<(Expense?, AppError)> insert(Expense expense) async {
    try {
      final model = _toModel(expense);
      realm.write(() => realm.add(model));
      return (_toEntity(model), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Expense>, AppError)> findAll() async {
    try {
      final results = realm.all<ExpenseModel>();
      final expenses = results.map(_toEntity).toList();
      return (expenses, Empty());
    } catch (e) {
      return (List<Expense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(List<Expense>, AppError)> findByMonth(
      {required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      final results = realm
          .all<ExpenseModel>()
          .query(r'date >= $0 AND date <= $1', [start, end]);
      final expenses = results.map(_toEntity).toList();

      return (expenses, Empty());
    } catch (e) {
      return (List<Expense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Expense?, AppError)> update(Expense expense) async {
    try {
      final model = realm.find<ExpenseModel>(expense.id);

      if (model == null) {
        return (null, Failure("Expense not found"));
      }

      realm.write(() {
        model.amount = expense.amount;
        model.date = expense.date;
        model.description = expense.description;
        model.category = expense.category;
      });

      return (_toEntity(model), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> delete(Expense expense) async {
    try {
      final model = realm.find<ExpenseModel>(expense.id);

      if (model == null) {
        return (null, Failure("Expense not found"));
      }

      realm.write(() => realm.delete(model));
      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  Expense _toEntity(ExpenseModel model) {
    return Expense(
      id: model.id,
      amount: model.amount,
      date: model.date,
      description: model.description,
      category: model.category,
    );
  }

  ExpenseModel _toModel(Expense expense) {
    var model = ExpenseModel(
      expense.id ?? uuid.v4(),
      expense.amount,
      expense.date,
      expense.description,
      '',
    );
    model.category = expense.category;
    return model;
  }
}
