import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_month.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_list/expense_list_view_model.dart';
import 'package:provider/provider.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseListViewModel(context),
      builder: (context, child) {
        final viewModel = Provider.of<ExpenseListViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarCustom(title: context.intl.expense),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => viewModel.onAdd(),
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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

  Widget itemList(ExpenseListViewModel viewModel, BuildContext context) {
    if (viewModel.list.isEmpty) {
      return Expanded(child: Center(child: Text(context.intl.no_expenses)));
    }

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        itemCount: viewModel.list.length,
        itemBuilder: (context, index) {
          var expense = viewModel.list[index];

          return item(expense, viewModel, context);
        },
      ),
    );
  }

  Widget item(
    Expense expense,
    ExpenseListViewModel controller,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(expense.category.getIcon()),
          const SizedBox(width: 16),
          Text(
            context.currency.format(expense.amount),
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
