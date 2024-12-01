import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';

class OfflineFirstFixedExpenseRepository implements FixedExpenseRepository {
  final FixedExpenseRepository localRepository;
  final FixedExpenseRepository remoteRepository;

  OfflineFirstFixedExpenseRepository({
    required this.localRepository,
    required this.remoteRepository,
  });

  @override
  Future<(FixedExpense?, AppError)> insert(FixedExpense fixedExpense) async {
    try {
      var (localFixedExpense, localError) =
          await localRepository.insert(fixedExpense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.insert(fixedExpense);
      if (remoteError is! Empty) {
        // if (remoteError.message.contains("not logged in")) {
        //   return (
        //     localFixedExpense,
        //     Warning(
        //         "Inserted locally, but remote sync failed: User not logged in.")
        //   );
        // }
        return (
          localFixedExpense,
          Warning("Inserted locally, but remote sync failed.")
        );
      }

      return (localFixedExpense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<FixedExpense>, AppError)> findAll() async {
    try {
      var (localFixedExpenses, localError) = await localRepository.findAll();
      if (localError is Empty && localFixedExpenses.isNotEmpty) {
        return (localFixedExpenses, Empty());
      }

      var (remoteFixedExpenses, remoteError) = await remoteRepository.findAll();
      if (remoteError is Empty) {
        for (var fixedExpense in remoteFixedExpenses) {
          await localRepository.insert(fixedExpense);
        }
        return (remoteFixedExpenses, Empty());
      }

      // if (remoteError.message.contains("not logged in")) {
      //   return (
      //     localFixedExpenses,
      //     Warning(
      //         "Used local data, but remote sync failed: User not logged in.")
      //   );
      // }

      return (
        List<FixedExpense>.empty(),
        Failure("Could not retrieve fixed expenses from local or remote.")
      );
    } catch (e) {
      return (List<FixedExpense>.empty(), Failure(e.toString()));
    }
  }

  @override
  Future<(FixedExpense?, AppError)> update(FixedExpense fixedExpense) async {
    try {
      var (updatedFixedExpense, localError) =
          await localRepository.update(fixedExpense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.update(fixedExpense);
      if (remoteError is! Empty) {
        // if (remoteError.message.contains("not logged in")) {
        //   return (
        //     updatedFixedExpense,
        //     Warning(
        //         "Updated locally, but remote sync failed: User not logged in.")
        //   );
        // }
        return (
          updatedFixedExpense,
          Warning("Updated locally, but remote sync failed.")
        );
      }

      return (updatedFixedExpense, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> delete(FixedExpense fixedExpense) async {
    try {
      var (_, localError) = await localRepository.delete(fixedExpense);
      if (localError is! Empty) return (null, localError);

      var (_, remoteError) = await remoteRepository.delete(fixedExpense);
      if (remoteError is! Empty) {
        // if (remoteError.message.contains("not logged in")) {//TODO para esse caso aqui tem um técnica que eu vi no app runique muito legal de parse de erro que talvez fique legal aqui
        //   return (
        //     null,
        //     Warning(
        //         "Deleted locally, but remote sync failed: User not logged in.")
        //   );
        // }
        return (null, Warning("Deleted locally, but remote sync failed."));
      }

      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
