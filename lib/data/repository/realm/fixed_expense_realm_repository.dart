import 'package:my_kakeibo/data/repository/realm/model/fixed_expense_model.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/data/repository/fixed_expense_repository.dart';
import 'package:realm/realm.dart' hide Uuid;
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

class FixedExpenseRealmRepository extends FixedExpenseRepository {
  final Realm realm;
  final Uuid uuid;

  FixedExpenseRealmRepository(this.realm, this.uuid);

  @override
  Future<Result<FixedExpense>> insert(FixedExpense fixedExpense) async {
    try {
      final model = _toModel(fixedExpense);
      realm.write(() => realm.add(model));
      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<FixedExpense>>> findAll() async {
    try {
      final results = realm.all<FixedExpenseModel>();
      final fixedExpenses = results.map(_toEntity).toList();
      return Success(fixedExpenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<FixedExpense>> update(FixedExpense fixedExpense) async {
    try {
      final model = realm.find<FixedExpenseModel>(fixedExpense.id);

      if (model == null) {
        return Failure(Exception("Fixed expense not found"));
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

      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    try {
      final model = realm.find<FixedExpenseModel>(fixedExpense.id);

      if (model == null) {
        return Failure(Exception("Fixed expense not found"));
      }

      realm.write(() => realm.delete(model));
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
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
