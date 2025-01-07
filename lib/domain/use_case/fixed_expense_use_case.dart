import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseUseCase {
  ExpenseRepository expenseRepository;
  FixedExpenseRepository fixedExpenseRepository;
  UserUseCase userUseCase;

  FixedExpenseUseCase({
    required this.fixedExpenseRepository,
    required this.expenseRepository,
    required this.userUseCase,
  });

  Future<Result<void>> pay(FixedExpense fixedExpense) async {
    var expense = Expense(
      id: null,
      amount: fixedExpense.amount,
      date: DateTime.now(),
      description: fixedExpense.description,
      category: fixedExpense.category,
    );

    var persistedExpense = await expenseRepository.insert(expense).getOrThrow();

    fixedExpense.pay(persistedExpense);

    await fixedExpenseRepository.update(fixedExpense).getOrThrow();

    return const Success("ok");
  }

  Future<Result<void>> insert(FixedExpense fixedExpense) async {
    if (fixedExpense.id != null) {
      await fixedExpenseRepository.update(fixedExpense);
    } else {
      await fixedExpenseRepository.insert(fixedExpense);
    }

    return const Success("ok");
  }

  Future<Result<List<FixedExpense>>> findAll() async {
    return await fixedExpenseRepository.findAll();
  }

  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    return await fixedExpenseRepository.delete(fixedExpense);
  }
}
