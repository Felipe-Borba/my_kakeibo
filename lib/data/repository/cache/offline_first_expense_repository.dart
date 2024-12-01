import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';

class OfflineFirstExpenseRepository implements ExpenseRepository {
  final ExpenseRepository localRepository;
  final ExpenseRepository remoteRepository;

  OfflineFirstExpenseRepository({
    required this.localRepository,
    required this.remoteRepository,
  });

  @override
  Future<(Expense?, AppError)> insert(Expense expense) async {
    try {
      var (localExpense, localError) = await localRepository.insert(expense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.insert(expense);
      if (remoteError is! Empty) {
        return (localExpense, Warning("Local saved but remote sync failed"));
      }

      return (localExpense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<Expense>, AppError)> findAll() async {
    try {
      var (localExpenses, localError) = await localRepository.findAll();
      if (localError is Empty && localExpenses.isNotEmpty) {
        return (localExpenses, Empty());
      }

      var (remoteExpenses, remoteError) = await remoteRepository.findAll();
      if (remoteError is Empty) {
        for (var expense in remoteExpenses) {
          await localRepository.insert(expense);
        }
        return (remoteExpenses, Empty());
      }

      return (
        List<Expense>.empty(),
        Failure("Could not retrieve expenses from local or remote.")
      );
    } catch (e) {
      return (List<Expense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(List<Expense>, AppError)> findByMonth({
    required DateTime month,
  }) async {
    try {
      var (localExpenses, localError) =
          await localRepository.findByMonth(month: month);
      if (localError is Empty && localExpenses.isNotEmpty) {
        return (localExpenses, Empty());
      }

      var (remoteExpenses, remoteError) =
          await remoteRepository.findByMonth(month: month);
      if (remoteError is Empty) {
        for (var expense in remoteExpenses) {
          await localRepository.insert(expense);
        }
        return (remoteExpenses, Empty());
      }

      return (
        List<Expense>.empty(),
        Failure("Could not retrieve expenses for the specified month.")
      );
    } catch (e) {
      return (List<Expense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(Expense?, AppError)> update(Expense expense) async {
    try {
      var (localExpense, localError) = await localRepository.update(expense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.update(expense);
      if (remoteError is! Empty) {
        return (localExpense, Warning("Local updated but remote sync failed"));
      }

      return (localExpense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> delete(Expense expense) async {
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
