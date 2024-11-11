import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/core/components/input_field/month_selector.dart';
import 'package:my_kakeibo/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/core/components/sort_component.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/expense/expense_list/expense_list_controller.dart';
import 'package:provider/provider.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  static const routeName = '/expense-list';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseListController(context),
      builder: (context, child) {
        final controller = Provider.of<ExpenseListController>(context);
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
              appBar: AppBarCustom(title: intl.expense),
              endDrawer: const DrawerCustom(),
              floatingActionButton: FloatingActionButton.small(
                onPressed: () => controller.onAdd(),
                child: const Icon(Icons.add),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 32, height: 24),
                        MonthSelector(
                          onMonthSelected: controller.setMonthFilter,
                          initialDate: controller.monthFilter,
                        ),
                        SortComponent(
                          onSortChanged: controller.setSortBy,
                          sortNumber: controller.sortNumber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: controller.list.length,
                        itemBuilder: (context, index) {
                          var expense = controller.list[index];

                          return item(
                            expense,
                            formatter,
                            controller,
                            context,
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

  Widget item(
    Expense expense,
    NumberFormat formatter,
    ExpenseListController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(expense.category.icon),
          const SizedBox(width: 16),
          Text(
            formatter.format(expense.amount),
          ),
          const SizedBox(width: 16),
          Text(
            DateFormat.Md(
              Localizations.localeOf(context).toString(),
            ).format(expense.date),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(expense.description)),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => controller.onEdit(expense),
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () async {
              var confirm = await showDeleteDialog(context);
              if (confirm == true) {
                controller.onDelete(expense);
              }
            },
          ),
        ],
      ),
    );
  }
}
