import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_view.dart';
import 'package:my_kakeibo/presentation/income/income_list/income_list_view.dart';
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
            color: Colors.green[300],
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My Kakeibo',
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
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {
              Modular.to.navigate(DashboardView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Expense'),
            onTap: () {
              Modular.to.navigate(ExpenseListView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Income'),
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
              title: const Text('Settings'),
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
