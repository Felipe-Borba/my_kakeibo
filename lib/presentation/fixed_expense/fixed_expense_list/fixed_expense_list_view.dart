import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/core/components/sort_component.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/fixed_expense/fixed_expense_list/fixed_expense_list_controller.dart';
import 'package:provider/provider.dart';

class FixedExpenseListView extends StatelessWidget {
  const FixedExpenseListView({super.key});

  static const routeName = '/fixed-expense-list';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FixedExpenseListController(context),
      builder: (context, child) {
        final controller = Provider.of<FixedExpenseListController>(context);
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
              appBar: AppBarCustom(title: intl.fixedExpense),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
    FixedExpense fixedExpense,
    NumberFormat formatter,
    FixedExpenseListController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(fixedExpense.category.icon),
          const SizedBox(width: 16),
          Text(
            formatter.format(fixedExpense.description),
          ),
          const SizedBox(width: 16),
          Text(
            DateFormat.Md(
              Localizations.localeOf(context).toString(),
            ).format(fixedExpense.dueDate),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => controller.onEdit(fixedExpense),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () async {
              var confirm = await showDeleteDialog(context);
              if (confirm == true) {
                controller.onDelete(fixedExpense);
              }
            },
          ),
        ],
      ),
    );
  }
}
