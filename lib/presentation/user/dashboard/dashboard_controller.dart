// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import 'package:my_kakeibo/core/components/charts/pie_chart_custom.dart';
import 'package:my_kakeibo/core/expense_category_helper.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/use_case/expense_use_case.dart';
import 'package:my_kakeibo/domain/use_case/income_use_case.dart';
import 'package:my_kakeibo/domain/use_case/notification_use_case.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardController with ChangeNotifier {
  DashboardController(this._context);

  // Dependencies
  final userUseCase = Modular.get<UserUseCase>();
  final expenseUseCase = Modular.get<ExpenseUseCase>();
  final incomeUseCase = Modular.get<IncomeUseCase>();
  final notificationUseCase = Modular.get<NotificationUseCase>();
  final BuildContext _context;
  late final intl = AppLocalizations.of(_context)!;
  late final NumberFormat moneyFormatter = NumberFormat.currency(
    locale: Localizations.localeOf(_context).toString(),
    symbol: intl.currencyTag,
    decimalDigits: 2,
  );

  // State
  double total = 0;
  double totalIncome = 0;
  double totalExpense = 0;
  List<Transaction> list = List.empty();
  List<PieData> pieChartData = List.empty();
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
    _makePieCartData(expenseList);

    var (user, userError) = await userUseCase.getUser();
    if (user != null) {
      await notificationUseCase.checkPushNotificationSettings(user);
    }
    this.user = user;
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
          color = Colors.green;
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
        label: ExpenseCategoryHelper.getTranslation(
          entry.key,
          context: _context,
        ),
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
}
