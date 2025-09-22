import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/settings/settings_screen.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_form_view.dart';
import 'package:my_kakeibo/presentation/user/income/income_form/income_form_view.dart';
import 'package:my_kakeibo/presentation/user/transaction/transaction_list/transaction_list_view.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel(
    this._userRepository,
    this._expenseRepository,
    this._incomeRepository,
    this._context,
  ) {
    getInitialData();
  }

  // Dependencies
  final BuildContext _context;
  final UserRepository _userRepository;
  final ExpenseRepository _expenseRepository;
  final IncomeRepository _incomeRepository;

  // State
  double total = 0;
  double totalIncome = 0;
  double totalExpense = 0;
  List<Transaction> list = List.empty();
  User? user;

  // Actions
  getInitialData() async {
    var totalIncome =
        (await _incomeRepository.getMonthTotal()).getOrDefault(0.0);
    var totalExpense =
        (await _expenseRepository.getMonthTotal()).getOrDefault(0.0);
    this.totalIncome = totalIncome;
    this.totalExpense = totalExpense;
    total = totalIncome - totalExpense;
    if (total < 0) {
      total = 0;
    }

    var now = DateTime.now();
    var incomeList = (await _incomeRepository.findByMonth(month: now))
        .getOrDefault(List.empty());
    var expenseList = (await _expenseRepository.findByMonth(month: now))
        .getOrDefault(List.empty());
    list = [...incomeList, ...expenseList];
    list.sort((a, b) => b.date.compareTo(a.date));

    var result = await _userRepository.getUser();
    result.onSuccess((user) async {
      this.user = user;
      notifyListeners();
    });
    notifyListeners();
  }

  void onSettingsPressed() {
    _context.pushScreen(const SettingsScreen());
  }

  void onAddIncomePressed() {
    _context.pushScreen(const IncomeFormView());
  }

  void onAddExpensePressed() {
    _context.pushScreen(const ExpenseFormView());
  }

  void onInsightsPressed() {
    _context.pushScreen(const DashboardView());
  }

  void onMenuPressed() {
    final scaffold = Scaffold.maybeOf(_context);
    if (scaffold != null && !scaffold.isDrawerOpen) {
      scaffold.openEndDrawer();
    }
  }

  void onSeeAllPressed() {
    _context.pushScreen(const TransactionListView());
  }
}
