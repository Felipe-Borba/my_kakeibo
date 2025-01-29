import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/presentation/core/components/card_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_body_medium.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_label_medium.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/date_time_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/icon_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_list/fixed_expense_list_view_model.dart';
import 'package:provider/provider.dart';

class FixedExpenseListView extends StatelessWidget {
  const FixedExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FixedExpenseListViewModel(context),
      builder: (context, child) {
        final viewModel = Provider.of<FixedExpenseListViewModel>(context);
        return ScaffoldCustom(
          appBar: AppBarCustom(title: context.intl.fixedExpense),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => viewModel.onAdd(),
            child: const Icon(Icons.add),
          ),
          body: body(viewModel, context),
        );
      },
    );
  }

  Widget body(FixedExpenseListViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
    );
  }

  Widget itemList(FixedExpenseListViewModel viewModel, BuildContext context) {
    if (viewModel.list.isEmpty) {
      return Expanded(
          child: Center(child: Text(context.intl.no_fixed_expenses)));
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
    FixedExpense fixedExpense,
    FixedExpenseListViewModel controller,
    BuildContext context,
  ) {
    return CardCustom(
      children: [
        const SizedBox(width: 16),
        Icon(fixedExpense.category.icon.toIconData()),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (fixedExpense.description.isNotEmpty)
                TextBodyMedium(fixedExpense.description)
              else
                TextBodyMedium(fixedExpense.category.name),
              TextBodyMedium(
                context.currency.format(fixedExpense.amount),
                prominent: true,
              ),
              TextLabelMedium(
                fixedExpense.frequency.getTranslation(context),
              ),
              TextLabelMedium(
                fixedExpense.dueDate.formatToString(context),
              )
            ],
          ),
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
        IconButton(
          onPressed: fixedExpense.alreadyPaid
              ? null
              : () async {
                  var response = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(context.intl.confirmPayment),
                        content: Text(context.intl.confirmPaymentText),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(context.intl.cancel),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(context.intl.pay),
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
        ),
      ],
    );
  }
}
