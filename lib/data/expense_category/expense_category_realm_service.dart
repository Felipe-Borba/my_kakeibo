import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:my_kakeibo/data/realm/realm_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseCategoryRealmService {
  final RealmService _realmService;

  ExpenseCategoryRealmService(this._realmService);

  Future<Result<ExpenseCategory>> insert(
    ExpenseCategory expenseCategory,
  ) async {
    try {
      var model = toModel(expenseCategory);
      _realmService.realm.write(() {
        model = _realmService.realm.add<ExpenseCategoryModel>(model);
      });
      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<ExpenseCategory>>> findAll() async {
    try {
      final results = _realmService.realm.all<ExpenseCategoryModel>();
      final expenseCategories = results.map(toEntity).toList();
      return Success(expenseCategories);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<ExpenseCategory>> findOne(
    ExpenseCategory expenseCategory,
  ) async {
    try {
      final model =
          _realmService.realm.find<ExpenseCategoryModel>(expenseCategory.id);

      if (model == null) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<ExpenseCategory>> update(
    ExpenseCategory expenseCategory,
  ) async {
    try {
      final model =
          _realmService.realm.find<ExpenseCategoryModel>(expenseCategory.id);

      if (model == null) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      _realmService.realm.write(() {
        model.name = expenseCategory.name;
        model.color = expenseCategory.color;
        model.icon = expenseCategory.icon;
      });

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<void>> delete(ExpenseCategory expenseCategory) async {
    try {
      final model =
          _realmService.realm.find<ExpenseCategoryModel>(expenseCategory.id);

      if (model == null) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      _realmService.realm.write(() => _realmService.realm.delete(model));
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  static ExpenseCategory toEntity(ExpenseCategoryModel model) {
    return ExpenseCategory(
      id: model.id,
      name: model.name,
      color: model.color,
      icon: model.icon,
    );
  }

  ExpenseCategoryModel toModel(ExpenseCategory expenseCategory) {
    return ExpenseCategoryModel(
      expenseCategory.id ?? "",
      expenseCategory.name,
      expenseCategory.color.index,
      expenseCategory.icon.index,
    );
  }
}
