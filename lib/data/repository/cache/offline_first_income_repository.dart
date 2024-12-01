import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';

class OfflineFirstIncomeRepository implements IncomeRepository {
  final IncomeRepository localRepository;
  final IncomeRepository remoteRepository;

  OfflineFirstIncomeRepository({
    required this.localRepository,
    required this.remoteRepository,
  });

  @override
  Future<(Income?, AppError)> insert(Income expense) async {
    try {
      var (localIncome, localError) = await localRepository.insert(expense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.insert(expense);
      if (remoteError is! Empty) {
        return (localIncome, Warning("Local saved but remote sync failed"));
      }

      return (localIncome, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Income>, AppError)> findAll() async {
    try {
      var (localIncomes, localError) = await localRepository.findAll();
      if (localError is Empty && localIncomes.isNotEmpty) {
        return (localIncomes, Empty());
      }

      var (remoteIncomes, remoteError) = await remoteRepository.findAll();
      if (remoteError is Empty) {
        for (var expense in remoteIncomes) {
          await localRepository.insert(expense);//TODO pode dar problema aqui porque isso pode ser um registro existente ou novo e esse método é exclusivo para novos regsitros, se trocar pela update o firebase não se resolve???
        }
        return (remoteIncomes, Empty());
      }

      return (
        List<Income>.empty(),
        Failure("Could not retrieve expenses from local or remote.")
      );
    } catch (e) {
      return (List<Income>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(List<Income>, AppError)> findByMonth({
    required DateTime month,
  }) async {
    try {
      var (localIncomes, localError) =
          await localRepository.findByMonth(month: month);
      if (localError is Empty && localIncomes.isNotEmpty) {
        return (localIncomes, Empty());
      }

      var (remoteIncomes, remoteError) =
          await remoteRepository.findByMonth(month: month);
      if (remoteError is Empty) {
        for (var expense in remoteIncomes) {
          await localRepository.insert(expense);
        }
        return (remoteIncomes, Empty());
      }

      return (
        List<Income>.empty(),
        Failure("Could not retrieve expenses for the specified month.")
      );
    } catch (e) {
      return (List<Income>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Income?, AppError)> update(Income expense) async {
    try {
      var (localIncome, localError) = await localRepository.update(expense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.update(expense);
      if (remoteError is! Empty) {
        return (localIncome, Warning("Local updated but remote sync failed"));
      }

      return (localIncome, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> delete(Income expense) async {
    try {
      var (_, localError) = await localRepository.delete(expense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.delete(expense);
      if (remoteError is! Empty) {
        return (null, Warning("Deleted locally but remote sync failed"));
      }

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
