import 'package:my_kakeibo/data/expense_category/expense_category_realm_service.dart';
import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:my_kakeibo/data/realm/realm_service.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:realm/realm.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseRealmService {
  final RealmService _realmService;

  ExpenseRealmService(this._realmService);

  Future<Result<Expense>> insert(Expense expense) async {
    try {
      final model = _toModel(expense);
      _realmService.realm.write(() {
        var category =
            _realmService.realm.find<ExpenseCategoryModel>(expense.category.id);
        _realmService.realm.add(model..category = category);
      });
      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<Expense>>> findAll() async {
    try {
      final results = _realmService.realm.all<ExpenseModel>();
      final expenses = results.map(_toEntity).toList();
      return Success(expenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<List<Expense>>> findByMonth({required DateTime month}) async {
    try {
      final start = DateTime(month.year, month.month, 1);
      final end = DateTime(month.year, month.month + 1, 0);

      final results = _realmService.realm
          .all<ExpenseModel>()
          .query(r'date >= $0 AND date <= $1', [start, end]);
      final expenses = results.map(_toEntity).toList();

      return Success(expenses);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<Expense>> update(Expense expense) async {
    try {
      final model = _realmService.realm.find<ExpenseModel>(expense.id);

      if (model == null) {
        return Failure(CustomException.expenseNotFound());
      }

      _realmService.realm.write(() {
        model.amount = expense.amount;
        model.date = expense.date;
        model.description = expense.description;
        model.category = _realmService.realm.find<ExpenseCategoryModel>(
          expense.category.id,
        );
      });

      return Success(_toEntity(model));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<void>> delete(Expense expense) async {
    try {
      final model = _realmService.realm.find<ExpenseModel>(expense.id);

      if (model == null) {
        return Failure(CustomException.expenseNotFound());
      }

      _realmService.realm.write(() => _realmService.realm.delete(model));
      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Expense _toEntity(ExpenseModel model) {
    return Expense(
      id: model.id,
      amount: model.amount,
      date: model.date,
      description: model.description,
      category: ExpenseCategoryRealmService.toEntity(model.category!),
    );
  }

  ExpenseModel _toModel(Expense expense) {
    return ExpenseModel(
      expense.id ?? RealmService.generateUuid(),
      expense.amount,
      expense.date,
      expense.description,
    );
  }
}
