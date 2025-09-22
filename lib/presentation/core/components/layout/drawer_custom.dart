import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/app_version.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/navigator_extension.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';
import 'package:my_kakeibo/presentation/settings/settings_screen.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/expense_category/expense_category_list/expense_category_list_view.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_list/fixed_expense_list_view.dart';
import 'package:my_kakeibo/presentation/user/transaction/transaction_list/transaction_list_view.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

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
            leading: const Icon(Icons.receipt_long_outlined),
            title: Text(context.intl.transactions),
            onTap: () {
              scaffold.closeEndDrawer();
              context.pushScreen(const TransactionListView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: Text(context.intl.insights),
            onTap: () {
              scaffold.closeEndDrawer();
              context.pushScreen(const DashboardView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_membership),
            title: Text(context.intl.fixedExpense),
            onTap: () {
              scaffold.closeEndDrawer();
              context.pushScreen(const FixedExpenseListView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_rounded),
            title: Text(context.intl.expense_category),
            onTap: () {
              scaffold.closeEndDrawer();
              context.pushScreen(const ExpenseCategoryListView());
            },
          ),
          ListTile(
            key: WidgetKeys.settings,
            leading: const Icon(Icons.settings),
            title: Text(context.intl.settings),
            onTap: () {
              scaffold.closeEndDrawer();
              context.pushScreen(const SettingsScreen());
            },
          ),
          const Expanded(child: SizedBox(width: double.maxFinite)),
          const SafeArea(bottom: true, child: AppVersion()),
        ],
      ),
    );
  }
}
