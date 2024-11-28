import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

import '../../core/records/app_error.dart';

class FixedExpenseUseCase {
  ExpenseRepository expenseRepository;
  FixedExpenseRepository fixedExpenseRepository;
  UserUseCase userUseCase;

  FixedExpenseUseCase({
    required this.fixedExpenseRepository,
    required this.expenseRepository,
    required this.userUseCase,
  });

  Future<(Null, AppError)> pay(FixedExpense fixedExpense) async {
    var expense = Expense(
      id: null,
      amount: fixedExpense.amount,
      date: DateTime.now(),
      description: fixedExpense.description,
      category: fixedExpense.category,
    );

    var (persistedExpense, persistedExpenseErr) = await expenseRepository.insert(expense);
    if(persistedExpenseErr is Failure) {
      return (null, persistedExpenseErr);
    }
    fixedExpense.pay(persistedExpense!);
    var (persistedFixedExpense, persistedFixedExpenseErr) = await fixedExpenseRepository.update(fixedExpense);
    if(persistedFixedExpenseErr is Failure) {
      return (null, persistedFixedExpenseErr);
    }

    return (null, Empty());
  }

  Future<(Null, AppError)> insert(FixedExpense fixedExpense) async {
    if (fixedExpense.id != null) {
      await fixedExpenseRepository.update(fixedExpense);
    } else {
      await fixedExpenseRepository.insert(fixedExpense);
    }

    return (null, Empty());
  }

  Future<(List<FixedExpense>, AppError)> findAll() async {
    return await fixedExpenseRepository.findAll();
  }

  Future<(Null, AppError)> delete(FixedExpense fixedExpense) async {
    return await fixedExpenseRepository.delete(fixedExpense);
  }
}
