import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/extensions/dependency_manager_extension.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/presentation/core/components/charts/pie_chart_custom.dart';
import 'package:my_kakeibo/presentation/user/dashboard/home_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/insights_view.dart';

class DashboardViewModel with ChangeNotifier {
  DashboardViewModel(this._context) {
    getInitialData();
  }

  // Dependencies
  final BuildContext _context;
  late final userUseCase = _context.dependencyManager.userUseCase;
  late final expenseUseCase = _context.dependencyManager.expenseUseCase;
  late final incomeUseCase = _context.dependencyManager.incomeUseCase;
  late final notificationUseCase =
      _context.dependencyManager.notificationUseCase;
  late final NumberFormat moneyFormatter = NumberFormat.currency(
    locale: Localizations.localeOf(_context).toString(),
    symbol: _context.intl.currencyTag,
    decimalDigits: 2,
  );

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
    var totalIncome = (await incomeUseCase.getMonthTotal()).getOrDefault(0.0);
    var totalExpense = (await expenseUseCase.getMonthTotal()).getOrDefault(0.0);
    this.totalIncome = totalIncome;
    this.totalExpense = totalExpense;
    total = totalIncome - totalExpense;
    if (total < 0) {
      total = 0;
    }

    var now = DateTime.now();
    var incomeList = (await incomeUseCase.findByMonth(month: now))
        .getOrDefault(List.empty());
    var expenseList = (await expenseUseCase.findByMonth(month: now))
        .getOrDefault(List.empty());
    list = [...incomeList, ...expenseList];
    list.sort((a, b) => a.date.compareTo(b.date));
    _makePieCartData(expenseList);

    var result = await userUseCase.getUser();
    result.onSuccess((user) async {
      await notificationUseCase.checkPushNotificationSettings(user);
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
      Color color;
      switch (entry.key) {
        case ExpenseCategory.food:
          color = Colors.brown;
          break;
        case ExpenseCategory.entertainment:
          color = Colors.purple;
          break;
        case ExpenseCategory.rent:
          color = Colors.blue;
          break;
        case ExpenseCategory.misc:
          color = Colors.orange;
          break;
      }

      return PieData(
        color: color,
        value: entry.value,
        title: moneyFormatter.format(entry.value),
        label: entry.key.getTranslation(_context),
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
