import 'package:my_kakeibo/data/expense/expense_realm_service.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_realm_service.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseRepository {
  final FixedExpenseRealmService _fixedExpenseRealmService;
  final ExpenseRealmService _expenseRealmService;

  FixedExpenseRepository(
    this._fixedExpenseRealmService,
    this._expenseRealmService,
  );

  Future<Result<void>> pay(FixedExpense fixedExpense) async {
    var expense = Expense(
      id: null,
      amount: fixedExpense.amount,
      date: DateTime.now(),
      description: fixedExpense.description,
      category: fixedExpense.category,
    );

    var persistedExpense =
        await _expenseRealmService.insert(expense).getOrThrow();

    fixedExpense.pay(persistedExpense);

    await _fixedExpenseRealmService.update(fixedExpense).getOrThrow();

    return const Success("ok");
  }

  Future<Result<void>> insert(FixedExpense fixedExpense) async {
    if (fixedExpense.id != null) {
      await _fixedExpenseRealmService.update(fixedExpense);
    } else {
      await _fixedExpenseRealmService.insert(fixedExpense);
    }

    return const Success("ok");
  }

  Future<Result<List<FixedExpense>>> findAll() async {
    return await _fixedExpenseRealmService.findAll();
  }

  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    return await _fixedExpenseRealmService.delete(fixedExpense);
  }
}
