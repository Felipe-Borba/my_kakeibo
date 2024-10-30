import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_controller.dart';
import 'package:my_kakeibo/core/components/show_delete_dialog.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  static const routeName = '/expense-list';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ExpenseListController>();

    return FutureBuilder(
      future: controller.getInitialData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: const AppBarCustom(title: "Expense"),
              drawer: const DrawerCustom(),
              floatingActionButton: FloatingActionButton.small(
                onPressed: () => controller.onAdd(),
                child: const Icon(Icons.add),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    // TODO filter
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: controller.list.length,
                        itemBuilder: (context, index) {
                          var expense = controller.list[index];

                          return Dismissible(
                            key: Key(expense.id!),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) async {
                              await controller.onDelete(expense);
                            },
                            confirmDismiss: (direction) async {
                              return await showDeleteDialog(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(expense.category.icon),
                                  const SizedBox(width: 16),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'pt_BR',
                                      symbol: 'R\$',
                                    ).format(expense.amount),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    DateFormat('dd/MM').format(expense.date),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    onPressed: () => controller.onEdit(expense),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
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
