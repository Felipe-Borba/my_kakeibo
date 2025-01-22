import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/extensions/currency.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/month_selector.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/user/income/income_list/income_list_controller.dart';
import 'package:provider/provider.dart';

class IncomeListView extends StatelessWidget {
  const IncomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeListController(context),
      builder: (context, child) {
        final viewModel = Provider.of<IncomeListController>(context);

        return ScaffoldCustom(
          appBar: AppBarCustom(title: context.intl.income),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => viewModel.onAdd(),
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
                      onMonthSelected: viewModel.setMonthFilter,
                      initialDate: viewModel.monthFilter,
                    ),
                    SortComponent(
                      onSortChanged: viewModel.setSortBy,
                      sortNumber: viewModel.sortNumber,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                itemList(viewModel, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget itemList(IncomeListController viewModel, BuildContext context) {
    if (viewModel.list.isEmpty) {
      return Expanded(child: Center(child: Text(context.intl.no_incomes)));
    }

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: viewModel.list.length,
        itemBuilder: (context, index) {
          var income = viewModel.list[index];

          return item(income, viewModel, context);
        },
      ),
    );
  }

  Widget item(
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
            context.currency.format(income.amount),
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
