import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_service_sqlite.dart';
import 'package:my_kakeibo/data/notification/local_notification_service.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/notification/local_notification.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:result_dart/result_dart.dart';

class FixedExpenseRepository {
  final FixedExpenseServiceSqlite _fixedExpenseRealmService;
  final ExpenseServiceSqlite _expenseRealmService;
  final UserServiceSqlite _userServiceSqlite;
  final LocalNotificationService _localNotificationService;

  FixedExpenseRepository(
      this._fixedExpenseRealmService,
      this._expenseRealmService,
      this._userServiceSqlite,
      this._localNotificationService);

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

  AsyncResult<Unit> insert(
      FixedExpense fixedExpense, LocalNotification? localNotification) async {
    if (fixedExpense.id != null) {
      return await _fixedExpenseRealmService
          .update(fixedExpense)
          .flatMap((expense) => const Success(unit));
    } else {
      return await _userServiceSqlite.getSelf().flatMap((user) =>
          _fixedExpenseRealmService
              .insert(fixedExpense.copyWith(userId: user.id))
              .flatMap(
            (expense) async {
              if (localNotification != null) {
                await _localNotificationService.scheduleNotification(
                  localNotification,
                );
              }
              return Success(expense);
            },
          ).flatMap((expense) => const Success(unit)));
    }
  }

  Future<Result<List<FixedExpense>>> findAll() async {
    return await _fixedExpenseRealmService.findAll();
  }

  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    return await _fixedExpenseRealmService.delete(fixedExpense);
  }
}
