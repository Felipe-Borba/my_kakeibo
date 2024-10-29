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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(controller.user!.name),
              ),
              drawer: const DrawerCustom(),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    // Container 1 - Exibição dos valores
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Valores'),
                          SizedBox(height: 8),
                          Text("1"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    // Container 2 - Lista de despesas em formato de coluna
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.list.length,
                                itemBuilder: (context, index) {
                                  var expense = controller.list[index];

                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            expense is Income
                                                ? 'Inbound'
                                                : 'Outbound',
                                            style: const TextStyle(
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                16), // Espaço entre elementos
                                        Expanded(
                                          child: Text(
                                            NumberFormat.currency(
                                                    locale: 'pt_BR',
                                                    symbol: 'R\$')
                                                .format(expense.amount),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                16), // Espaço entre elementos
                                        Expanded(
                                          child: Icon(
                                            expense is Expense
                                                ? expense.category.icon
                                                : Icons
                                                    .monetization_on_outlined,
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                16), // Espaço entre elementos
                                        Expanded(
                                          child: Text(
                                            DateFormat('dd/MM')
                                                .format(expense.date),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
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
