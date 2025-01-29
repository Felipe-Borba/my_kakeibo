import 'package:my_kakeibo/data/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/data/repository/realm/expense_category_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/model/models.dart';
import 'package:my_kakeibo/data/repository/realm/realm_config.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:realm/realm.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseRealmRepository extends FixedExpenseRepository {
  final realm = RealmConfig().realm;

  @override
  Future<Result<FixedExpense>> insert(FixedExpense fixedExpense) async {
    try {
      final model = _toModel(fixedExpense);
      realm.write(() {
        var category =
            realm.find<ExpenseCategoryModel>(fixedExpense.category.id);
        realm.add(model..category = category);
      });
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
        return Failure(CustomException.fixedExpenseNotFound());
      }

      realm.write(() {
        model.amount = fixedExpense.amount;
        model.dueDate = fixedExpense.dueDate;
        model.description = fixedExpense.description;
        model.category = realm.find<ExpenseCategoryModel>(
          fixedExpense.category.id,
        );
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
        return Failure(CustomException.fixedExpenseNotFound());
      }

      realm.write(() => realm.delete(model));
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  static FixedExpense _toEntity(FixedExpenseModel model) {
    return FixedExpense(
      id: model.id,
      amount: model.amount,
      dueDate: model.dueDate,
      description: model.description,
      category: ExpenseCategoryRealmRepository.toEntity(model.category!),
      frequency: model.frequency,
      remember: model.remember,
      expenseIdList: model.expenseIdList,
    );
  }

  static FixedExpenseModel _toModel(FixedExpense fixedExpense) {
    final uuid = RealmConfig().uuid;

    return FixedExpenseModel(
      fixedExpense.id ?? uuid.v4(),
      fixedExpense.dueDate,
      fixedExpense.description,
      fixedExpense.amount,
      fixedExpense.frequency.description,
      fixedExpense.remember.description,
      expenseIdList: fixedExpense.expenseIdList,
    );
  }
}
