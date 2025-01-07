import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseUseCase {
  ExpenseRepository expenseRepository;
  UserUseCase userUseCase;

  ExpenseUseCase({
    required this.expenseRepository,
    required this.userUseCase,
  });

  Future<Result<void>> insert(Expense expense) async {
    var user = await userUseCase.getUser().getOrThrow();

    user.decreaseBalance(expense.amount);
    await userUseCase.update(user);

    if (expense.id != null) {
      await expenseRepository.update(expense);
    } else {
      await expenseRepository.insert(expense);
    }

    return const Success("ok");
  }

  Future<Result<List<Expense>>> findAll() async {
    return await expenseRepository.findAll();
  }

  Future<Result<List<Expense>>> findByMonth({
    required DateTime month,
  }) async {
    return await expenseRepository.findByMonth(month: month);
  }

  Future<Result<void>> delete(Expense expense) async {
    return await expenseRepository.delete(expense);
  }

  Future<Result<double>> getMonthTotal() async {
    var expenseList = await expenseRepository
        .findByMonth(month: DateTime.now()) //
        .getOrThrow();

    var total = expenseList.fold(0.0, (sum, expense) => sum + expense.amount);
    return Success(total);
  }
}
