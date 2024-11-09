import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';

class DashboardController with ChangeNotifier {
  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();
  final expenseUseCase = Modular.get<ExpenseUseCase>();
  final incomeUseCase = Modular.get<IncomeUseCase>();

  // State
  double total = 0;
  double totalIncome = 0;
  double totalExpense = 0;
  List<Transaction> list = List.empty();
  User? user;

  // Actions
  getInitialData() async {
    var (totalIncome, totalIncomeError) = await incomeUseCase.getMonthTotal();
    var (totalExpense, totalExpenseError) =
        await expenseUseCase.getMonthTotal();
    total = totalIncome - totalExpense;
    this.totalIncome = totalIncome;
    this.totalExpense = totalExpense;

    var now = DateTime.now();
    var (incomeList, incomeListError) = await incomeUseCase.findByMonth(
      month: now,
    );
    var (expenseList, expenseListError) = await expenseUseCase.findByMonth(
      month: now,
    );
    list = [...incomeList, ...expenseList];
    list.sort((a, b) => a.date.compareTo(b.date));

    var (user, userError) = await userUseCase.getUser();
    this.user = user;
  }
}
