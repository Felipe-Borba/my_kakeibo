import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:result_dart/result_dart.dart';

abstract class FixedExpenseRepository {
  Future<Result<FixedExpense>> insert(FixedExpense fixedExpense);

  Future<Result<List<FixedExpense>>> findAll();

  Future<Result<FixedExpense>> update(FixedExpense fixedExpense);

  Future<Result<void>> delete(FixedExpense fixedExpense);
}
