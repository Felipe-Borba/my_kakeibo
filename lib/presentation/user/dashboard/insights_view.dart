import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/charts/pie_chart_custom.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_title_large.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DashboardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Column(
        children: [
          const TextTitleLarge("Gasto mensal por categoria"),
          PieChartCustom(data: controller.pieChartData),
        ],
      ),
    );
  }
}
