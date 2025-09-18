import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view_model.dart';
import 'package:my_kakeibo/presentation/user/dashboard/insights_view.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel(
        context.read(),
        context.read(),
        // context.read(),
      ),
      builder: (BuildContext context, Widget? child) {
        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.insights,
          ),
          body: const InsightsView(),
        );
      },
    );
  }
}
