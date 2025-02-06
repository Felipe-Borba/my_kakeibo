import 'package:my_kakeibo/data/income/income_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:result_dart/result_dart.dart';

class IncomeRepository {
  final IncomeServiceSqlite _incomeRealmService;

  IncomeRepository(
    this._incomeRealmService,
  );

  Future<Result<void>> save(Income income) async {
    if (income.id != null) {
      await _incomeRealmService.update(income);
    } else {
      await _incomeRealmService.insert(income);
    }

    return const Success("ok");
  }

  Future<Result<List<Income>>> findAll() async {
    return await _incomeRealmService.findAll();
  }

  Future<Result<List<Income>>> findByMonth({
    required DateTime month,
  }) async {
    return await _incomeRealmService.findByMonth(month: month);
  }

  Future<Result<void>> delete(Income income) async {
    return await _incomeRealmService.delete(income);
  }

  Future<Result<double>> getMonthTotal() async {
    var incomeList = await _incomeRealmService
        .findByMonth(month: DateTime.now()) //
        .getOrThrow();

    var total = incomeList.fold(0.0, (sum, income) => sum + income.amount);
    return Success(total);
  }
}
