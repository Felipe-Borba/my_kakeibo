import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_service_sqlite.dart';
import 'package:my_kakeibo/data/notification/local_notification_service.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
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
    this._localNotificationService,
  );

  Future<Result<void>> pay({
    required FixedExpense fixedExpense,
    required String notificationTitle,
  }) async {
    final expense = Expense(
      id: null,
      amount: fixedExpense.amount,
      date: DateTime.now(),
      description: fixedExpense.description,
      category: fixedExpense.category,
      userId: fixedExpense.userId,
    );

    final persistedExpense = await _expenseRealmService //
        .insert(expense)
        .getOrThrow();

    final payedExpense = fixedExpense.pay(persistedExpense);

    final (updatedFixedExpense, notification) = payedExpense //
        .makeNotificationForPayment(notificationTitle);

    if (notification != null && notification.inFuture()) {
      await _localNotificationService.scheduleNotification(notification);
    }

    await _fixedExpenseRealmService.update(updatedFixedExpense).getOrThrow();

    return const Success("ok");
  }

  AsyncResult<Unit> insert({
    String? id,
    required String description,
    required ExpenseCategory category,
    DateTime? dueDate,
    required double amount,
    required List<Expense> expenseList,
    required Frequency frequency,
    required Remember remember,
    required String notificationTitle,
  }) async {
    final (fixedExpense, notification) = FixedExpense(
      id: id,
      description: description,
      category: category,
      dueDate: dueDate ??= DateTime.now(),
      amount: amount,
      expenseList: expenseList,
      frequency: frequency,
      remember: remember,
    ).makeNotificationForPayment(notificationTitle);

    if (fixedExpense.id != null) {
      return await _fixedExpenseRealmService
          .update(fixedExpense)
          .flatMap((expense) => const Success(unit));
    } else {
      return await _userServiceSqlite.getSelf().flatMap(
            (user) => _fixedExpenseRealmService
                .insert(fixedExpense.copyWith(userId: user.id))
                .flatMap(
              (expense) async {
                if (notification != null && notification.inFuture()) {
                  await _localNotificationService.scheduleNotification(
                    notification,
                  );
                }
                return Success(expense);
              },
            ).flatMap((expense) => const Success(unit)),
          );
    }
  }

  Future<Result<List<FixedExpense>>> findAll() async {
    return await _fixedExpenseRealmService.findAll();
  }

  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    return await _fixedExpenseRealmService.delete(fixedExpense);
  }
}
