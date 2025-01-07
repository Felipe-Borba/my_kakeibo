import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:result_dart/result_dart.dart';

class IncomeUseCase {
  IncomeRepository incomeRepository;
  UserUseCase userUseCase;

  IncomeUseCase({
    required this.incomeRepository,
    required this.userUseCase,
  });

  Future<Result<void>> insert(Income income) async {
    var user = await userUseCase.getUser().getOrThrow();

    user.increaseBalance(income.amount);
    await userUseCase.update(user);
    if (income.id != null) {
      await incomeRepository.update(income);
    } else {
      await incomeRepository.insert(income);
    }

    return const Success("ok");
  }

  Future<Result<List<Income>>> findAll() async {
    return await incomeRepository.findAll();
  }

  Future<Result<List<Income>>> findByMonth({
    required DateTime month,
  }) async {
    return await incomeRepository.findByMonth(month: month);
  }

  Future<Result<void>> delete(Income income) async {
    return await incomeRepository.delete(income);
  }

  Future<Result<double>> getMonthTotal() async {
    var incomeList = await incomeRepository
        .findByMonth(month: DateTime.now()) //
        .getOrThrow();

    var total = incomeList.fold(0.0, (sum, income) => sum + income.amount);
    return Success(total);
  }
}
