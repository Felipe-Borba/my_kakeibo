import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entity/transaction/expense.dart';
import '../../../domain/entity/user/user.dart';
import '../../../domain/use_case/expense_use_case.dart';
import '../../../domain/use_case/user_use_case.dart';

class DashboardController with ChangeNotifier {
  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();
  final expenseUseCase = Modular.get<ExpenseUseCase>();

  // State
  double total = 0;
  List<Expense> expenseList = List.empty();
  User? user;

  // Actions
  getInitialData() async {
    var (total, totalError) = await expenseUseCase.getMonthTotal();
    this.total = total;

    var (list, listError) = await expenseUseCase.findAll();
    expenseList = list;

    var (user, userError) = await userUseCase.getUser();
    this.user = user;
  }
}
