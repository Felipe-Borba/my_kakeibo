import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_view.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_view.dart';
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
            height: 130,
            width: double.maxFinite,
            color: Colors.blue,
            child: const DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
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
              Modular.to.navigate(IncomeFormView.routeName);
            },
          ),
          const Expanded(child: SizedBox(width: double.maxFinite)),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Modular.to.navigate(SettingsView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
