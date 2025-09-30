import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/data/user/user_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseRepository {
  final ExpenseServiceSqlite _expenseRealmService;
  final UserServiceSqlite _userServiceSqlite;

  ExpenseRepository(
    this._expenseRealmService,
    this._userServiceSqlite,
  );

  AsyncResult<Expense> save(Expense expense) async {
    if (expense.id != null) {
      return await _expenseRealmService.update(expense);
    } else {
      return await _userServiceSqlite.getSelf().flatMap((user) {
        return _expenseRealmService.insert(expense.copyWith(userId: user.id));
      });
    }
  }

  Future<Result<List<Expense>>> findAll() async {
    return await _expenseRealmService.findAll();
  }

  Future<Result<List<Expense>>> findByMonth({
    required DateTime month,
  }) async {
    return await _expenseRealmService.findByMonth(month: month);
  }

  Future<Result<void>> delete(Expense expense) async {
    return await _expenseRealmService.delete(expense);
  }

  Future<Result<double>> getMonthTotal() async {
    var expenseList = await _expenseRealmService
        .findByMonth(month: DateTime.now()) //
        .getOrThrow();

    var total = expenseList.fold(0.0, (sum, expense) => sum + expense.amount);
    return Success(total);
  }
}
