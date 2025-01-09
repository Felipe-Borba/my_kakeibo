import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/data/repository/expense_repository.dart';
import 'package:result_dart/result_dart.dart';

class OfflineFirstExpenseRepository implements ExpenseRepository {
  final ExpenseRepository localRepository;
  final ExpenseRepository remoteRepository;

  OfflineFirstExpenseRepository({
    required this.localRepository,
    required this.remoteRepository,
  });

  @override
  Future<Result<Expense>> insert(Expense expense) async {
    try {
      var localResult = await localRepository.insert(expense);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.insert(expense);
      if (remoteResult.isError()) {
        return Success(localResult.getOrThrow());
      }

      return remoteResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Expense>>> findAll() async {
    try {
      var localResult = await localRepository.findAll();
      if (localResult.isError()) {
        var remoteResult = await remoteRepository.findAll();
        if (remoteResult.isError()) {
          return Failure(Exception(
            "Could not retrieve expenses from local or remote.",
          ));
        }

        for (var expense in remoteResult.getOrThrow()) {
          await localRepository.insert(expense);
        }

        return remoteResult;
      }

      return localResult;
    } on Exception catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Expense>>> findByMonth({
    required DateTime month,
  }) async {
    try {
      var localResult = await localRepository.findByMonth(month: month);
      if (localResult.isError()) {
        var remoteResult = await remoteRepository.findByMonth(month: month);
        if (remoteResult.isError()) {
          return Failure(Exception(
            "Could not retrieve expenses for the specified month from local or remote.",
          ));
        }

        for (var expense in remoteResult.getOrThrow()) {
          await localRepository.insert(expense);
        }

        return remoteResult;
      }

      return localResult;
    } on Exception catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<Expense>> update(Expense expense) async {
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
  Future<Result<void>> delete(Expense expense) async {
    try {
      var localResult = await localRepository.delete(expense);
      if (localResult.isError()) return localResult;

      var remoteResult = await remoteRepository.delete(expense);
      if (remoteResult.isError()) {
        return Failure(Exception("Deleted locally but remote sync failed"));
      }

      return localResult;
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
