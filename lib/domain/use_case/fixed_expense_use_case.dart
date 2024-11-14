import 'package:my_kakeibo/domain/entity/fixed_expense.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/fixed_expense_repository.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

import '../../core/records/app_error.dart';

class FixedExpenseUseCase {
  ExpenseRepository expenseRepository;
  FixedExpenseRepository fixedExpenseRepository;
  UserUseCase userUseCase;

  FixedExpenseUseCase({
    required this.fixedExpenseRepository,
    required this.expenseRepository,
    required this.userUseCase,
  });

  Future<(Null, AppError)> pagar(FixedExpense fixedExpense) async {
    //TODO fazer logica paga registrar uma expense como pagamento da despesa fixa
    return (null, Empty());
  }

  Future<(Null, AppError)> insert(FixedExpense fixedExpense) async {
    //TODO o pulo do gato aqui é ter uma nova entidade de pespesa fixa
    // e na data do vencimento/pagamento cadastrar como expense,
    // isso deixaria flexivel e com possibilidade de calculo de juros, controle de mes pago, etc...
    // talvez complique um pouco para mostrar os dados na home como despesa projetada ou add ela direto como despesa...
    return (null, Empty());
  }

  Future<(List<FixedExpense>, AppError)> findAll() async {
    return await fixedExpenseRepository.findAll();
  }

  Future<(Null, AppError)> delete(FixedExpense fixedExpense) async {
    return await fixedExpenseRepository.delete(fixedExpense);
  }
}
