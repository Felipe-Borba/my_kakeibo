import 'package:my_kakeibo/data/repository/expense_repository.dart';
import 'package:my_kakeibo/data/repository/realm/expense_category_realm_repository.dart';
import 'package:my_kakeibo/data/repository/realm/model/models.dart';
import 'package:my_kakeibo/data/repository/realm/realm_config.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:realm/realm.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseRealmRepository extends ExpenseRepository {
  final realm = RealmConfig().realm;

  @override
  Future<Result<Expense>> insert(Expense expense) async {
    try {
      final model = _toModel(expense);
      realm.write(() {
        var category = realm.find<ExpenseCategoryModel>(expense.category.id);
        realm.add(model..category = category);
      });
      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Expense>>> findAll() async {
    try {
      final results = realm.all<ExpenseModel>();
      final expenses = results.map(_toEntity).toList();
      return Success(expenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Expense>>> findByMonth({required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      final results = realm
          .all<ExpenseModel>()
          .query(r'date >= $0 AND date <= $1', [start, end]);
      final expenses = results.map(_toEntity).toList();

      return Success(expenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Expense>> update(Expense expense) async {
    try {
      final model = realm.find<ExpenseModel>(expense.id);

      if (model == null) {
        return Failure(CustomException.expenseNotFound());
      }

      realm.write(() {
        model.amount = expense.amount;
        model.date = expense.date;
        model.description = expense.description;
        model.category = realm.find<ExpenseCategoryModel>(
          expense.category.id,
        );
      });

      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> delete(Expense expense) async {
    try {
      final model = realm.find<ExpenseModel>(expense.id);

      if (model == null) {
        return Failure(CustomException.expenseNotFound());
      }

      realm.write(() => realm.delete(model));
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  static Expense _toEntity(ExpenseModel model) {
    return Expense(
      id: model.id,
      amount: model.amount,
      date: model.date,
      description: model.description,
      category: ExpenseCategoryRealmRepository.toEntity(model.category!),
    );
  }

  static ExpenseModel _toModel(Expense expense) {
    final uuid = RealmConfig().uuid;

    return ExpenseModel(
      expense.id ?? uuid.v4(),
      expense.amount,
      expense.date,
      expense.description,
    );
  }
}
