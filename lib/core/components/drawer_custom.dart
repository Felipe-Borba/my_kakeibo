import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/snackbar_custom.dart';
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/use_case/user_use_case.dart';
import 'package:my_kakeibo/presentation/settings/settings_view.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view.dart';
import 'package:my_kakeibo/presentation/user/login/login_view.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userUseCase = Modular.get<UserUseCase>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 130,
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
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Modular.to.navigate(SettingsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              var (_, err) = await userUseCase.logOut();
              if (err is Failure) {
                showSnackbar(context: context, text: err.message);
              } else if (err is Empty) {
                Modular.to.navigate(LoginView.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
