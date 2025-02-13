import 'package:my_kakeibo/data/income_source/income_source_service_sqlite.dart';
import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:result_dart/result_dart.dart';

class IncomeSourceRepository {
  final IncomeSourceServiceSqlite _incomeSourceRealmService;

  IncomeSourceRepository(this._incomeSourceRealmService);

  Future<Result<IncomeSource>> save(IncomeSource incomeSource) {
    if (incomeSource.id == null) {
      return _incomeSourceRealmService.insert(incomeSource);
    } else {
      return _incomeSourceRealmService.update(incomeSource);
    }
  }

  Future<Result<List<IncomeSource>>> findAll() {
    return _incomeSourceRealmService.findAll();
  }

  Future<Result<void>> delete(IncomeSource incomeSource) {
    return _incomeSourceRealmService.delete(incomeSource);
  }
}
