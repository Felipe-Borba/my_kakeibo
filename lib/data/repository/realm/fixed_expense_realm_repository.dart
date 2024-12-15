import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/realm/model/fixed_expense_model.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:uuid/uuid.dart';

class FixedExpenseRealmRepository extends FixedExpenseRepository {
  final Realm realm;
  final Uuid uuid; 

  FixedExpenseRealmRepository(this.realm, this.uuid);

  @override
  Future<(FixedExpense?, AppError)> insert(FixedExpense fixedExpense) async {
    try {
      final model = _toModel(fixedExpense);
      realm.write(() => realm.add(model));
      return (_toEntity(model), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<FixedExpense>, AppError)> findAll() async {
    try {
      final results = realm.all<FixedExpenseModel>();
      final fixedExpenses = results.map(_toEntity).toList();
      return (fixedExpenses, Empty());
    } catch (e) {
      return (List<FixedExpense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(FixedExpense?, AppError)> update(FixedExpense fixedExpense) async {
    try {
      final model = realm.find<FixedExpenseModel>(fixedExpense.id);

      if (model == null) {
        return (null, Failure("Fixed expense not found"));
      }

      realm.write(() {
        model.amount = fixedExpense.amount;
        model.dueDate = fixedExpense.dueDate;
        model.description = fixedExpense.description;
        model.category = fixedExpense.category;
        model.frequency = fixedExpense.frequency;
        model.remember = fixedExpense.remember;
        model.expenseIdList = RealmList(fixedExpense.expenseIdList);
      });

      return (_toEntity(model), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> delete(FixedExpense fixedExpense) async {
    try {
      final model = realm.find<FixedExpenseModel>(fixedExpense.id);

      if (model == null) {
        return (null, Failure("Fixed expense not found"));
      }

      realm.write(() => realm.delete(model));
      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  FixedExpense _toEntity(FixedExpenseModel model) {
    return FixedExpense(
      id: model.id,
      amount: model.amount,
      dueDate: model.dueDate,
      description: model.description,
      category: model.category,
      frequency: model.frequency,
      remember: model.remember,
      expenseIdList: model.expenseIdList,
    );
  }

  FixedExpenseModel _toModel(FixedExpense fixedExpense) {
    var model = FixedExpenseModel(
      fixedExpense.id ?? uuid.v4(),
      fixedExpense.dueDate,
      fixedExpense.description,
      "",
      "",
      "",
      fixedExpense.amount,
      expenseIdList: fixedExpense.expenseIdList,
    );
    model.category = fixedExpense.category;
    model.remember = fixedExpense.remember;
    model.frequency = fixedExpense.frequency;
    return model;
  }
}
