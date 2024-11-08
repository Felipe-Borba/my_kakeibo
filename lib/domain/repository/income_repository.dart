import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';

abstract class IncomeRepository {
  Future<(Income?, AppError)> insert(Income income);

  // Future<(Income?, AppError)> getOne(String id);

  Future<(List<Income>, AppError)> findAll();

  Future<(List<Income>, AppError)> findByMonth({required DateTime month});

  Future<(Income?, AppError)> update(Income income);

  Future<(Null, AppError)> delete(Income income);
}
