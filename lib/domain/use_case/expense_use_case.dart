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
    var (user!, userErr) = await userUseCase.getUser();
    if (userErr is! Empty) {
      return (null, userErr);
    }

    user.decreaseBalance(expense.amount);
    await userUseCase.update(user);

    if (expense.id != null) {
      await expenseRepository.update(expense);
    } else {
      await expenseRepository.insert(expense);
    }

    return (null, Empty());
  }

  Future<(List<Expense>, AppError)> findAll() async {
    return await expenseRepository.findAll();
  }

  Future<(List<Expense>, AppError)> findByMonth({
    required DateTime month,
  }) async {
    return await expenseRepository.findByMonth(month: month);
  }

  Future<(Null, AppError)> delete(Expense expense) async {
    return await expenseRepository.delete(expense);
  }

  Future<(double, AppError)> getMonthTotal() async {
    var (expenseList, err) = await expenseRepository.findByMonth(
      month: DateTime.now(),
    );

    if (err is! Empty) {
      return (0.0, err);
    }

    var total = expenseList.fold(0.0, (sum, expense) => sum + expense.amount);
    return (total, Empty());
  }
}
