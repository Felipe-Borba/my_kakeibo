import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/core/components/card_custom.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_month.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/date_time_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/user/income/income_list/income_list_view_model.dart';
import 'package:provider/provider.dart';

class IncomeListView extends StatelessWidget {
  const IncomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeListViewModel(context, context.read()),
      builder: (context, child) {
        final viewModel = Provider.of<IncomeListViewModel>(context);

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
                    InputMonth(
                      onMonthSelected: viewModel.setMonthFilter,
                      initialDate: viewModel.monthFilter,
                    ),
                    SortComponent(
                      onSortChanged: viewModel.setSortBy,
                      sort: viewModel.sort,
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

  Widget itemList(IncomeListViewModel viewModel, BuildContext context) {
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
    IncomeListViewModel controller,
    BuildContext context,
  ) {
    return CardCustom(
      children: [
        const SizedBox(width: 16),
        const Icon(Icons.monetization_on_outlined),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (income.description.isNotEmpty)
                TextCustom(income.description, theme: CustomTheme.bodyMedium)
              else
                TextCustom(income.source.name, theme: CustomTheme.bodyMedium),
              TextCustom(
                context.currency.format(income.amount),
                prominent: true,
                theme: CustomTheme.bodyMedium,
              ),
              TextCustom(
                income.date.formatToString(context),
                theme: CustomTheme.labelMedium,
              ),
            ],
          ),
        ),
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
    );
  }
}
