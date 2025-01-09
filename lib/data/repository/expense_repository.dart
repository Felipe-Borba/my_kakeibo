import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:result_dart/result_dart.dart';

abstract class ExpenseRepository {
  Future<Result<Expense>> insert(Expense expense);

  Future<Result<List<Expense>>> findAll();

  Future<Result<List<Expense>>> findByMonth({required DateTime month});

  Future<Result<Expense>> update(Expense expense);

  Future<Result<void>> delete(Expense expense);
}
