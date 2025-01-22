import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_user.dart';
import 'package:my_kakeibo/presentation/core/components/layout/bottom_navigation_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel(context),
      builder: (BuildContext context, Widget? child) {
        final viewModel = Provider.of<DashboardViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarUser(
            title: context.intl.welcomeMessage(viewModel.user?.name ?? ""),
          ),
          body: viewModel.screen,
          bottomNavigationBar: BottomNavigationBarCustom(
            currentIndexNotifier: viewModel.selectedIndex,
            onTabTapped: viewModel.onTabTapped,
          ),
        );
      },
    );
  }
}
