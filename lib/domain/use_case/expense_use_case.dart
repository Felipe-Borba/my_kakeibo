import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

import '../../core/records/app_error.dart';

class ExpenseUseCase {
  ExpenseRepository expenseRepository;
  UserUseCase userUseCase;

  ExpenseUseCase({
    required this.expenseRepository,
    required this.userUseCase,
  });

  Future<(Null, AppError)> insert(Expense expense) async {
    var (isValid, errorList) = expense.validate();
    if (!isValid) {
      return (null, errorList);
    }
    var (user!, userErr) = await userUseCase.getUser();
    if (userErr is! Empty) {
      return (null, userErr);
    }

    user.decreaseBalance(expense.amount);
    await expenseRepository.insert(expense);

    return (null, Empty());
  }

  Future<(List<Expense>, AppError)> findAll() async {
    return await expenseRepository.findAll();
  }

  Future<(Null, AppError)> delete(Expense expense) async {
    return await expenseRepository.delete(expense);
  }

  Future<(double, AppError)> getMonthTotal() async {
    return (0.0, Empty()); //TODO to be implemented
  }
}
