import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/charts/bar_chart_custom.dart';
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
              context.intl.monthSpending,
              theme: CustomTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            if (viewModel.pieChartData.isEmpty)
              Center(
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Text(context.intl.no_transactions),
                ),
              )
            else
              // month Spending by Category Pie Chart
              PieChartCustom(data: viewModel.pieChartData),
            const SizedBox(height: 24),
            BarChartCustom(
              data: viewModel.barChartData,
              title: context.intl.income_vs_expense,
              incomeLabel: context.intl.income,
              expenseLabel: context.intl.expense,
            ),
          ],
        ),
      ),
    );
  }
}
