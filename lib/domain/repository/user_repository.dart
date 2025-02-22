import 'dart:async';

import 'package:my_kakeibo/data/analytics_service.dart';
import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/expense_category/expense_category_service_sqlite.dart';
import 'package:my_kakeibo/data/fixed_expense/fixed_expense_service_sqlite.dart';
import 'package:my_kakeibo/data/income/income_service_sqlite.dart';
import 'package:my_kakeibo/data/income_source/income_source_service_sqlite.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:result_dart/result_dart.dart';

class UserRepository {
  final UserServiceSqlite _userService;
  final AnalyticsService _analyticsService;
  final ExpenseCategoryServiceSqlite _expenseCategoryService;
  final ExpenseServiceSqlite _expenseService;
  final FixedExpenseServiceSqlite _fixedExpenseService;
  final IncomeSourceServiceSqlite _incomeSourceService;
  final IncomeServiceSqlite _incomeService;

  UserRepository(
    this._userService,
    this._analyticsService,
    this._expenseCategoryService,
    this._expenseService,
    this._fixedExpenseService,
    this._incomeSourceService,
    this._incomeService,
  );

  final _streamController = StreamController<User>.broadcast();
  Stream<User> get userStream => _streamController.stream;

  AsyncResult<User> save(User user) {
    if (user.id != null) {
      return _userService.update(user).onSuccess((success) {
        _streamController.add(success);
      });
    } else {
      return _userService.insert(user).onSuccess((success) {
        _streamController.add(success);
      });
    }
  }

  AsyncResult<Unit> deleteUserData() async {
    await _userService.delete();
    await _expenseCategoryService.deleteAll();
    await _expenseService.deleteAll();
    await _fixedExpenseService.deleteAll();
    await _incomeSourceService.deleteAll();
    await _incomeService.deleteAll();
    return const Success(unit);
  }

  AsyncResult<User> getUser() async {
    return await _userService.getSelf();
  }

  getAnalyticsObserver() {
    return _analyticsService.getAnalyticsObserver();
  }

  logScreen(String name) {
    _analyticsService.logScreen(name);
  }
}
