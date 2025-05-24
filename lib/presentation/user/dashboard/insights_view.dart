import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/charts/pie_chart_custom.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DashboardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Column(
        children: [
          TextCustom(
            context.intl.monthlySpendingByCategory,
            theme: CustomTheme.titleMedium,
          ),
          if (viewModel.pieChartData.isEmpty)
            Expanded(child: Center(child: Text(context.intl.no_transactions)))
          else
            PieChartCustom(data: viewModel.pieChartData),
        ],
      ),
    );
  }
}
