import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_list/expense_list_view.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_list/fixed_expense_list_view.dart';
import 'package:my_kakeibo/presentation/user/income/income_list/income_list_view.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            color: const Color.fromARGB(255, 82, 178, 85),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.intl.appTitle,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '家計簿',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4)
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(context.intl.dashboard),
            onTap: () {
              context.pushReplacementScreen(const DashboardView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: Text(context.intl.expense),
            onTap: () {
              context.pushReplacementScreen(const ExpenseListView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_membership),
            title: Text(context.intl.fixedExpense),
            onTap: () {
              context.pushReplacementScreen(const FixedExpenseListView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text(context.intl.income),
            onTap: () {
              context.pushReplacementScreen(const IncomeListView());
            },
          ),
          const Expanded(child: SizedBox(width: double.maxFinite)),
          SafeArea(
            bottom: true,
            child: ListTile(
              key: const Key("settings"),
              leading: const Icon(Icons.settings),
              title: Text(context.intl.settings),
              onTap: () {
                context.pushReplacementScreen(const SettingsView());
              },
            ),
          ),
        ],
      ),
    );
  }
}
