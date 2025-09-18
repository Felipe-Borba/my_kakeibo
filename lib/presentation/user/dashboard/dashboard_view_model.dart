import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/domain/repository/expense_repository.dart';
import 'package:my_kakeibo/domain/repository/income_repository.dart';
import 'package:my_kakeibo/presentation/core/components/charts/bar_chart_custom.dart';
import 'package:my_kakeibo/presentation/core/components/charts/pie_chart_custom.dart';
import 'package:my_kakeibo/presentation/core/mappers/color_custom_mapper.dart';

class DashboardViewModel with ChangeNotifier {
  DashboardViewModel(
    this._expenseRepository,
    this._incomeRepository,
  ) {
    getInitialData();
  }

  // Dependencies
  final ExpenseRepository _expenseRepository;
  final IncomeRepository _incomeRepository;

  // State
  List<Transaction> list = List.empty();
  List<PieData> pieChartData = List.empty();
  List<BarData> barChartData = List.empty();

  // Actions
  getInitialData() async {
    var totalExpense =
        (await _expenseRepository.getMonthTotal()).getOrDefault(0.0);

    var now = DateTime.now();
    var incomeList = (await _incomeRepository.findByMonth(month: now))
        .getOrDefault(List.empty());
    var expenseList = (await _expenseRepository.findByMonth(month: now))
        .getOrDefault(List.empty());
    list = [...incomeList, ...expenseList];
    list.sort((a, b) => b.date.compareTo(a.date));
    makePieCartData(expenseList, totalExpense);

    // Generate bar chart data for the last 6 months
    await generateBarChartData();

    notifyListeners();
  }

  void makePieCartData(List<Expense> expenseList, double totalExpense) {
    var totalByCategory = _aggregateByCategory(expenseList);
    pieChartData = _convertToPieData(totalByCategory, totalExpense);
  }

  List<PieData> _convertToPieData(
    Map<ExpenseCategory, double> totalByCategory,
    double totalExpense,
  ) {
    List<PieData> pieDataList = totalByCategory.entries.map((entry) {
      return PieData(
        color: entry.key.color.toColor(),
        value: entry.value,
        title:
            "${totalExpense > 0 ? (entry.value / totalExpense * 100).round() : 0}%",
        label: entry.key.name,
      );
    }).toList()
      ..sort((a, b) => b.value.compareTo(a.value)); //TODO the bug still exists if list is unsorted

    // Adjust the last category to ensure the total is 100%
    if (pieDataList.isNotEmpty) {
      int totalPercentage = pieDataList.fold(
          0, (sum, item) => sum + _getPercentageString(item.title));
      int percentage = _getPercentageString(pieDataList.last.title);
      int difference = 100 - totalPercentage;
      int newPercentage = percentage + difference;
      pieDataList.last = PieData(
        color: pieDataList.last.color,
        value: pieDataList.last.value,
        title: "${newPercentage > 0 ? newPercentage : "<1"}%",
        label: pieDataList.last.label,
      );
    }

    return pieDataList;
  }

  int _getPercentageString(String title) {
    final percentageString = title.replaceAll('%', '');
    return int.tryParse(percentageString) ?? 0;
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

  Future<void> generateBarChartData() async {
    final List<BarData> data = [];
    final now = DateTime.now();

    // Get data for 2 months before and 3 months after the current month
    for (int i = -2; i <= 3; i++) {
      final month = DateTime(now.year, now.month + i, 1);
      final monthName = _getMonthAbbreviation(month);

      // Get income for this month
      final incomeResult = await _incomeRepository.findByMonth(month: month);
      final incomeList = incomeResult.getOrDefault(List.empty());
      final incomeTotal =
          incomeList.fold(0.0, (sum, income) => sum + income.amount);

      // Get expenses for this month
      final expenseResult = await _expenseRepository.findByMonth(month: month);
      final expenseList = expenseResult.getOrDefault(List.empty());
      final expenseTotal =
          expenseList.fold(0.0, (sum, expense) => sum + expense.amount);

      // Add to chart data
      data.add(BarData(
        month: monthName,
        income: incomeTotal,
        expense: expenseTotal,
      ));
    }

    barChartData = data;
  }

  String _getMonthAbbreviation(DateTime date) {
    final DateFormat formatter = DateFormat('MMM');
    return formatter.format(date);
  }
}
