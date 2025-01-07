import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:result_dart/result_dart.dart';

class OfflineFirstIncomeRepository implements IncomeRepository {
  final IncomeRepository localRepository;
  final IncomeRepository remoteRepository;

  OfflineFirstIncomeRepository({
    required this.localRepository,
    required this.remoteRepository,
  });

  @override
  Future<Result<Income>> insert(Income income) async {
    try {
      var localResult = await localRepository.insert(income);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.insert(income);
      if (remoteResult.isError()) {
        return Success(localResult.getOrThrow());
      }

      return remoteResult;
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Income>>> findAll() async {
    try {
      var localResult = await localRepository.findAll();
      if (localResult.isError()) {
        return localResult;
      }

      var remoteResult = await remoteRepository.findAll();
      if (remoteResult.isError()) {
        return Success(localResult.getOrThrow());
      }

      return remoteResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Income>>> findByMonth({required DateTime month}) async {
    try {
      var localResult = await localRepository.findByMonth(month: month);
      if (localResult.isError()) {
        return localResult;
      }

      var remoteResult = await remoteRepository.findByMonth(month: month);
      if (remoteResult.isError()) {
        return Success(localResult.getOrThrow());
      }

      for (var expense in remoteResult.getOrThrow()) {
        await localRepository.insert(expense);
      }

      return remoteResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Income>> update(Income expense) async {
    try {
      var localResult = await localRepository.update(expense);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.update(expense);
      if (remoteResult.isError()) {
        return Success(localResult.getOrThrow());
      }

      return remoteResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> delete(Income expense) async {
    try {
      var localResult = await localRepository.delete(expense);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.delete(expense);
      if (remoteResult.isError()) {
        return Failure(Exception("Deleted locally but remote sync failed"));
      }

      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
