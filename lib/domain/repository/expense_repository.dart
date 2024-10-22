import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';

abstract class ExpenseRepository {
  Future<(Expense?, AppError)> insert(Expense expense);

  // Future<(Expense?, AppError)> getOne(String id);

  Future<(List<Expense>, AppError)> findAll();

  Future<(Expense?, AppError)> update(Expense expense);

  Future<(Null, AppError)> delete(Expense expense);
}
