import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/charts/pie_chart_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/core/components/life_bar.dart';
import 'package:my_kakeibo/core/extensions/currency.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_controller.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    TextStyle? titleLarge = Theme.of(context).textTheme.titleLarge;

    return ChangeNotifierProvider(
      create: (context) => DashboardController(context),
      builder: (BuildContext context, Widget? child) {
        final controller = Provider.of<DashboardController>(context);

        return FutureBuilder(
          future: controller.getInitialData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return Scaffold(
              key: const Key("dashboard"),
              //TODO talvez colocar um botão flutuante aqui na home que abre outros btns para add os jaguara
              appBar: AppBarCustom(
                title: context.intl.welcomeMessage(controller.user?.name ?? ""),
              ),
              endDrawer: const DrawerCustom(),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    Text(
                      context.intl.total(
                        context.currency.format(controller.total),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: titleLarge?.color,
                      ),
                    ),
                    LifeBar(
                      total: controller.totalIncome,
                      current: controller.total,
                    ),
                    // const Divider(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_downward,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    context.intl.income,
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                context.currency.format(controller.totalIncome),
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_upward,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    context.intl.expense,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                context.currency
                                    .format(controller.totalExpense),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PieChartCustom(data: controller.pieChartData),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.list.length,
                        itemBuilder: (context, index) {
                          var transaction = controller.list[index];
                          return item(transaction, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Padding item(Transaction transaction, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              context.currency.format(transaction.amount),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            transaction is Income ? context.intl.income : context.intl.expense,
            style: const TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            //TODO aproveitando a vaibe das extentions fazer com isso tb
            DateFormat.MMMEd(
              Localizations.localeOf(context).toString(),
            ).format(transaction.date),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 16),
          Icon(
            transaction is Expense
                ? transaction.category.getIcon()
                : Icons.monetization_on_outlined,
          ),
        ],
      ),
    );
  }
}
