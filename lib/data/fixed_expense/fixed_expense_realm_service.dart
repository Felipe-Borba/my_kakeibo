import 'package:my_kakeibo/data/expense_category/expense_category_realm_service.dart';
import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:my_kakeibo/data/realm/realm_service.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:realm/realm.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseRealmService {
  final RealmService _realmService;

  FixedExpenseRealmService(this._realmService);

  Future<Result<FixedExpense>> insert(FixedExpense fixedExpense) async {
    try {
      var model = _toModel(fixedExpense);
      _realmService.realm.write(() {
        var category = _realmService.realm
            .find<ExpenseCategoryModel>(fixedExpense.category.id);
        model.category = category;
        _realmService.realm.add<FixedExpenseModel>(model);
      });
      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<FixedExpense>>> findAll() async {
    try {
      final results = _realmService.realm.all<FixedExpenseModel>();
      final fixedExpenses = results.map(_toEntity).toList();
      return Success(fixedExpenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<FixedExpense>> update(FixedExpense fixedExpense) async {
    try {
      final model =
          _realmService.realm.find<FixedExpenseModel>(fixedExpense.id);

      if (model == null) {
        return Failure(CustomException.fixedExpenseNotFound());
      }

      _realmService.realm.write(() {
        model.amount = fixedExpense.amount;
        model.dueDate = fixedExpense.dueDate;
        model.description = fixedExpense.description;
        model.category = _realmService.realm.find<ExpenseCategoryModel>(
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

  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    try {
      final model =
          _realmService.realm.find<FixedExpenseModel>(fixedExpense.id);

      if (model == null) {
        return Failure(CustomException.fixedExpenseNotFound());
      }

      _realmService.realm.write(() => _realmService.realm.delete(model));
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
      category: ExpenseCategoryRealmService.toEntity(model.category!),
      frequency: model.frequency,
      remember: model.remember,
      expenseIdList: model.expenseIdList,
    );
  }

  FixedExpenseModel _toModel(FixedExpense fixedExpense) {
    return FixedExpenseModel(
      fixedExpense.id ?? "",
      fixedExpense.dueDate,
      fixedExpense.description,
      fixedExpense.amount,
      fixedExpense.frequency.description,
      fixedExpense.remember.description,
      expenseIdList: fixedExpense.expenseIdList,
    );
  }
}
