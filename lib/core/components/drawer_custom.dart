import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_view.dart';
import 'package:my_kakeibo/presentation/fixed_expense/fixed_expense_list/fixed_expense_list_view.dart';
import 'package:my_kakeibo/presentation/income/income_list/income_list_view.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final intl = AppLocalizations.of(context)!;

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
                      intl.appTitle,
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
            title: Text(intl.dashboard),
            onTap: () {
              Modular.to.navigate(DashboardView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: Text(intl.expense),
            onTap: () {
              Modular.to.navigate(ExpenseListView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_membership),
            title: Text(intl.fixedExpense),
            onTap: () {
              Modular.to.navigate(FixedExpenseListView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text(intl.income),
            onTap: () {
              Modular.to.navigate(IncomeListView.routeName);
            },
          ),
          const Expanded(child: SizedBox(width: double.maxFinite)),
          SafeArea(
            bottom: true,
            child: ListTile(
              key: const Key("settings"),
              leading: const Icon(Icons.settings),
              title: Text(intl.settings),
              onTap: () {
                Modular.to.navigate(SettingsView.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
