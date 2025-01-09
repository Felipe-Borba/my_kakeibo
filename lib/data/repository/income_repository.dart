import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:result_dart/result_dart.dart';

abstract class IncomeRepository {
  Future<Result<Income>> insert(Income income);

  Future<Result<List<Income>>> findAll();

  Future<Result<List<Income>>> findByMonth({required DateTime month});

  Future<Result<Income>> update(Income income);

  Future<Result<void>> delete(Income income);
}
