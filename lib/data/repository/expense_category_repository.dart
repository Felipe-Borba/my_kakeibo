import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:result_dart/result_dart.dart';

abstract class ExpenseCategoryRepository {
  Future<Result<ExpenseCategory>> insert(ExpenseCategory expenseCategory);

  Future<Result<List<ExpenseCategory>>> findAll();

  Future<Result<ExpenseCategory>> findOne(
    ExpenseCategory expenseCategory,
  );

  Future<Result<ExpenseCategory>> update(ExpenseCategory expenseCategory);

  Future<Result<void>> delete(ExpenseCategory expenseCategory);
}
