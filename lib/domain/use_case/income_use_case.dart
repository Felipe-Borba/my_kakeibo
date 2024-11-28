import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

class IncomeUseCase {
  IncomeRepository incomeRepository;
  UserUseCase userUseCase;

  IncomeUseCase({
    required this.incomeRepository,
    required this.userUseCase,
  });

  // não usar o Income como parametro e mudar para os valores opcionais solitos
  Future<(Null, AppError)> insert(Income income) async {
    //TODO validar campos

    var (user!, userErr) = await userUseCase.getUser();
    if (userErr is! Empty) {
      return (null, userErr);
    }

    user.increaseBalance(income.amount);
    await userUseCase.update(user);
    if (income.id != null) {
      await incomeRepository.update(income);
    } else {
      await incomeRepository.insert(income);
    }

    return (null, Empty());
  }

  Future<(List<Income>, AppError)> findAll() async {
    return await incomeRepository.findAll();
  }

  Future<(List<Income>, AppError)> findByMonth({
    required DateTime month,
  }) async {
    return await incomeRepository.findByMonth(month: month);
  }

  Future<(Null, AppError)> delete(Income income) async {
    return await incomeRepository.delete(income);
  }

  Future<(double, AppError)> getMonthTotal() async {
    var (incomeList, err) = await incomeRepository.findByMonth(
      month: DateTime.now(),
    );

    if (err is! Empty) {
      return (0.0, err);
    }

    var total = incomeList.fold(0.0, (sum, income) => sum + income.amount);
    return (total, Empty());
  }
}
