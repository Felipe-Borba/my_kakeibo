import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/income/income_list/income_list_controller.dart';

class IncomeListView extends StatelessWidget {
  const IncomeListView({super.key});

  static const routeName = "/income-list";

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<IncomeListController>();

    return FutureBuilder(
      future: controller.getInitialData(context),
      builder: (context, snapshot) {
        return ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: const AppBarCustom(title: "Income"),
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
                    SortComponent(
                      onSortChanged: controller.sortBy,
                      sortNumber: controller.sortNumber,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: controller.list.length,
                        itemBuilder: (context, index) {
                          var income = controller.list[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.monetization_on_outlined),
                                const SizedBox(width: 16),
                                Text(
                                  NumberFormat.currency(
                                    locale: 'pt_BR',
                                    symbol: 'R\$',
                                  ).format(income.amount),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  DateFormat('dd/MM').format(income.date),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 16),
                                Expanded(child: Text(income.description)),
                                const SizedBox(width: 16),
                                IconButton(
                                  onPressed: () => controller.onEdit(income),
                                  icon: const Icon(Icons.edit),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () async {
                                    var confirm =
                                        await showDeleteDialog(context);
                                    if (confirm == true) {
                                      controller.onDelete(income);
                                    }
                                  },
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
