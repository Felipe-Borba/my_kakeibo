import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<DashboardController>();

    return FutureBuilder(
      future: controller.getInitialData(),
      builder: (context, snapshot) {
        return ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Bem vindo ${controller.user!.name}!"),
              ),
              drawer: const DrawerCustom(),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  // AQUI!!!!
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin:
                          const EdgeInsets.only(bottom: 16), // Espaço abaixo
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
                            NumberFormat.currency(
                              locale: 'pt_BR',
                              symbol: 'R\$',
                            ).format(controller.total),
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
                                NumberFormat.currency(
                                  locale: 'pt_BR',
                                  symbol: 'R\$',
                                ).format(controller.totalIncome),
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
                                NumberFormat.currency(
                                  locale: 'pt_BR',
                                  symbol: 'R\$',
                                ).format(controller.totalExpense),
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
                                Text(
                                  NumberFormat.currency(
                                    locale: 'pt_BR',
                                    symbol: 'R\$',
                                  ).format(transaction.amount),
                                ),
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
