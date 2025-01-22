import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/components/app_bar_user.dart';
import 'package:my_kakeibo/presentation/core/components/bottom_navigation_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel(context),
      builder: (BuildContext context, Widget? child) {
        final controller = Provider.of<DashboardViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarUser(
            title: context.intl.welcomeMessage(controller.user?.name ?? ""),
          ),
          body: controller.screen,
          bottomNavigationBar: BottomNavigationBarCustom(
            currentIndexNotifier: controller.selectedIndex,
            onTabTapped: controller.onTabTapped,
          ),
        );
      },
    );
  }
}
