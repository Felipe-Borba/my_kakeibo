import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

import '../../core/records/app_error.dart';

class ExpenseUseCase {
  ExpenseRepository expenseRepository;
  UserRepository userRepository;

  ExpenseUseCase({
    required this.expenseRepository,
    required this.userRepository,
  });

  Future<(Null, AppError)> insert(Expense expense) async {
    var (isValid, errorList) = expense.validate();
    if (!isValid) {
      return (null, errorList);
    }
    var (user!, userErr) = await userRepository.getUser();
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
}
