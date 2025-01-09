import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/presentation/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/drawer_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_list/fixed_expense_list_controller.dart';
import 'package:provider/provider.dart';

class FixedExpenseListView extends StatelessWidget {
  const FixedExpenseListView({super.key});

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
                            intl,
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
    AppLocalizations intl,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(fixedExpense.category.getIcon()),
                      const SizedBox(width: 8),
                      Text(fixedExpense.category.getTranslation(context)),
                      const SizedBox(width: 8),
                      Text(fixedExpense.description),
                    ],
                  ),
                  Row(
                    children: [
                      Text(fixedExpense.frequency.getTranslation(context)),
                      const SizedBox(width: 8),
                      Text(formatter.format(fixedExpense.amount)),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.Md(
                          Localizations.localeOf(context).toString(),
                        ).format(fixedExpense.dueDate),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
            IconButton(
              onPressed: fixedExpense.alreadyPaid
                  ? null
                  : () async {
                      var response = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(intl.confirmPayment),
                            content: Text(intl.confirmPaymentText),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text(intl.cancel),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(intl.pay),
                              ),
                            ],
                          );
                        },
                      );

                      if (response == true) {
                        await controller.pay(fixedExpense);
                      }
                    },
              icon: const Icon(Icons.payment),
            )
          ],
        ),
      ),
    );
  }
}
