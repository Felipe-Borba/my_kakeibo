import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:result_dart/result_dart.dart';

class OfflineFirstFixedExpenseRepository implements FixedExpenseRepository {
  final FixedExpenseRepository localRepository;
  final FixedExpenseRepository remoteRepository;

  OfflineFirstFixedExpenseRepository({
    required this.localRepository,
    required this.remoteRepository,
  });

  @override
  Future<Result<FixedExpense>> insert(FixedExpense fixedExpense) async {
    try {
      var localResult = await localRepository.insert(fixedExpense);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.insert(fixedExpense);
      if (remoteResult.isError()) {
        return Success(localResult.getOrThrow());
      }

      return remoteResult;
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<FixedExpense>>> findAll() async {
    try {
      var localResult = await localRepository.findAll();
      if (localResult.isError() || localResult.getOrThrow().isNotEmpty) {
        return localResult;
      }

      var remoteResult = await remoteRepository.findAll();
      if (remoteResult.isError()) {
        return remoteResult;
      }

      for (var fixedExpense in remoteResult.getOrThrow()) {
        await localRepository.insert(fixedExpense);
      }

      return remoteResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<FixedExpense>> update(FixedExpense fixedExpense) async {
    try {
      var localResult = await localRepository.update(fixedExpense);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.update(fixedExpense);
      if (remoteResult.isError()) {
        return Success(localResult.getOrThrow());
      }

      return remoteResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<void>> delete(FixedExpense fixedExpense) async {
    try {
      var localResult = await localRepository.delete(fixedExpense);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.delete(fixedExpense);
      if (remoteResult.isError()) {
        //TODO para esse caso aqui tem um técnica que eu vi no app runique muito legal de parse de erro que talvez fique legal aqui
        return Failure(Exception("Deleted locally but remote sync failed"));
      }

      return localResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
