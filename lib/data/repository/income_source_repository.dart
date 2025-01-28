import 'package:my_kakeibo/domain/entity/transaction/income_source.dart';
import 'package:result_dart/result_dart.dart';

abstract class IncomeSourceRepository {
  Future<Result<IncomeSource>> insert(IncomeSource incomeSource);

  Future<Result<List<IncomeSource>>> findAll();

  Future<Result<IncomeSource>> findOne(
    IncomeSource incomeSource,
  );

  Future<Result<IncomeSource>> update(IncomeSource incomeSource);

  Future<Result<void>> delete(IncomeSource incomeSource);
}
