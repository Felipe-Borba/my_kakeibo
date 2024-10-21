import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';

class ExpenseFirebaseRepository implements ExpenseRepository {
  @override
  Future<(Null, AppError)> delete(Expense expense) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<(List<Expense>, AppError)> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<(Expense, AppError)> insert(Expense expense) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<(Expense, AppError)> update(Expense expense) {
    // TODO: implement update
    throw UnimplementedError();
  }
}