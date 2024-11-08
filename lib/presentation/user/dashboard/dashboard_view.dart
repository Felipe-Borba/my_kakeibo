import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_controller.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardController(),
      builder: (BuildContext context, Widget? child) {
        final controller = Provider.of<DashboardController>(context);
        final intl = AppLocalizations.of(context)!;
        final NumberFormat formatter = NumberFormat.currency(
          locale: Localizations.localeOf(context).toString(),
          symbol: intl.currencyTag,
          decimalDigits: 2,
        );

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
              appBar: AppBar(
                title: Text("Bem vindo ${controller.user?.name}!"),
              ),
              drawer: const DrawerCustom(),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_balance,
                            color: Colors.black,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatter.format(controller.total),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Income',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatter.format(controller.totalIncome),
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Expense',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatter.format(controller.totalExpense),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.list.length,
                        itemBuilder: (context, index) {
                          var transaction = controller.list[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  transaction is Income ? 'Income' : 'Expense',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(formatter.format(transaction.amount)),
                                const SizedBox(width: 16),
                                Icon(
                                  transaction is Expense
                                      ? transaction.category.icon
                                      : Icons.monetization_on_outlined,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  DateFormat('dd/MM').format(transaction.date),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          );
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
}
