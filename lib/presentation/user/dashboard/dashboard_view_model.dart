import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/presentation/core/components/charts/pie_chart_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/color_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/user/dashboard/home_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/insights_view.dart';

class DashboardViewModel with ChangeNotifier {
  DashboardViewModel(
    this._context,
    this._userRepository,
    this._expenseRepository,
    this._incomeRepository,
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
  List<PieData> pieChartData = List.empty();
  User? user;
  final selectedIndex = ValueNotifier<int>(0);
  List<Widget> screens = [
    const HomeView(),
    const InsightsView(),
    // const ProfileView(),
  ];
  Widget get screen => screens[selectedIndex.value];

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
    _makePieCartData(expenseList);

    var result = await _userRepository.getUser();
    result.onSuccess((user) async {
      this.user = user;
      notifyListeners();
    });
    notifyListeners();
  }

  void _makePieCartData(List<Expense> expenseList) {
    var totalByCategory = _aggregateByCategory(expenseList);
    pieChartData = _convertToPieData(totalByCategory);
  }

  List<PieData> _convertToPieData(
    Map<ExpenseCategory, double> totalByCategory,
  ) {
    return totalByCategory.entries.map((entry) {
      return PieData(
        color: entry.key.color.toColor(),
        value: entry.value,
        title: _context.currency.format(entry.value),
        label: entry.key.name,
      );
    }).toList();
  }

  Map<ExpenseCategory, double> _aggregateByCategory(
    List<Expense> expenses,
  ) {
    Map<ExpenseCategory, double> totalByCategory = {};

    for (var expense in expenses) {
      totalByCategory.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return totalByCategory;
  }

  onTabTapped(int selectedIndex) {
    this.selectedIndex.value = selectedIndex;
    notifyListeners();
  }
}
