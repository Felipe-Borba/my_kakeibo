import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense.dart';

abstract class FixedExpenseRepository {
  Future<(FixedExpense?, AppError)> insert(FixedExpense fixedExpense);

  Future<(List<FixedExpense>, AppError)> findAll();

  Future<(FixedExpense?, AppError)> update(FixedExpense fixedExpense);

  Future<(Null, AppError)> delete(FixedExpense fixedExpense);
}
