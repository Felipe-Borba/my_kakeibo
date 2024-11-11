import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/core/components/input_field/month_selector.dart';
import 'package:my_kakeibo/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/core/components/sort_component.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/income/income_list/income_list_controller.dart';
import 'package:provider/provider.dart';

class IncomeListView extends StatelessWidget {
  const IncomeListView({super.key});

  static const routeName = "/income-list";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeListController(context),
      builder: (context, child) {
        final controller = Provider.of<IncomeListController>(context);
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
              appBar: AppBarCustom(title: intl.income),
              endDrawer: const DrawerCustom(),
              floatingActionButton: FloatingActionButton.small(
                onPressed: () => controller.onAdd(),
                child: const Icon(Icons.add),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
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
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: controller.list.length,
                        itemBuilder: (context, index) {
                          var income = controller.list[index];

                          return item(
                            formatter,
                            income,
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
    NumberFormat formatter,
    Income income,
    IncomeListController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.monetization_on_outlined),
          const SizedBox(width: 16),
          Text(
            formatter.format(income.amount),
          ),
          const SizedBox(width: 16),
          Text(
            DateFormat.Md(
              Localizations.localeOf(context).toString(),
            ).format(income.date),
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
              var confirm = await showDeleteDialog(context);
              if (confirm == true) {
                controller.onDelete(income);
              }
            },
          ),
        ],
      ),
    );
  }
}
