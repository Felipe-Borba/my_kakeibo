import 'package:my_kakeibo/data/expense/expense_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:result_dart/result_dart.dart';

class ExpenseRepository {
  final ExpenseServiceSqlite _expenseRealmService;

  ExpenseRepository(
    this._expenseRealmService,
  );

  Future<Result<void>> insert(Expense expense) async {

    if (expense.id != null) {
      await _expenseRealmService.update(expense);
    } else {
      await _expenseRealmService.insert(expense);
    }

    return const Success("ok");
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
