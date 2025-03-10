import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_service_sqlite.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseRepository {
  final FixedExpenseServiceSqlite _fixedExpenseRealmService;
  final ExpenseServiceSqlite _expenseRealmService;
  final UserServiceSqlite _userServiceSqlite;

  FixedExpenseRepository(
    this._fixedExpenseRealmService,
    this._expenseRealmService,
    this._userServiceSqlite,
  );

  Future<Result<void>> pay(FixedExpense fixedExpense) async {
    var expense = Expense(
      id: null,
      amount: fixedExpense.amount,
      date: DateTime.now(),
      description: fixedExpense.description,
      category: fixedExpense.category,
      userId: fixedExpense.userId,
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
      await _userServiceSqlite.getSelf().flatMap((user) {
        return _fixedExpenseRealmService.insert(
          fixedExpense.copyWith(userId: user.id),
        );
      });
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
