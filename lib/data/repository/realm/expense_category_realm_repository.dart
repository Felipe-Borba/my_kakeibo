import 'package:my_kakeibo/data/repository/expense_category_repository.dart';
import 'package:my_kakeibo/data/repository/realm/model/models.dart';
import 'package:my_kakeibo/data/repository/realm/realm_config.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseCategoryRealmRepository extends ExpenseCategoryRepository {
  final realm = RealmConfig().realm;

  @override
  Future<Result<ExpenseCategory>> insert(
      ExpenseCategory expenseCategory) async {
    try {
      final model = toModel(expenseCategory);
      realm.write(() => realm.add(model));
      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<ExpenseCategory>>> findAll() async {
    try {
      final results = realm.all<ExpenseCategoryModel>();
      final expenseCategories = results.map(toEntity).toList();
      return Success(expenseCategories);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<ExpenseCategory>> findOne(
    ExpenseCategory expenseCategory,
  ) async {
    try {
      final model = realm.find<ExpenseCategoryModel>(expenseCategory.id);

      if (model == null) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<ExpenseCategory>> update(
      ExpenseCategory expenseCategory) async {
    try {
      final model = realm.find<ExpenseCategoryModel>(expenseCategory.id);

      if (model == null) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      realm.write(() {
        model.name = expenseCategory.name;
        model.color = expenseCategory.color;
        model.icon = expenseCategory.icon;
      });

      return Success(toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> delete(ExpenseCategory expenseCategory) async {
    try {
      final model = realm.find<ExpenseCategoryModel>(expenseCategory.id);

      if (model == null) {
        return Failure(CustomException.expenseCategoryNotFound());
      }

      realm.write(() => realm.delete(model));
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

  static ExpenseCategoryModel toModel(ExpenseCategory expenseCategory) {
    final uuid = RealmConfig().uuid;
    return ExpenseCategoryModel(
      expenseCategory.id ?? uuid.v4(),
      expenseCategory.name,
      expenseCategory.color.index,
      expenseCategory.icon.index,
    );
  }
}
