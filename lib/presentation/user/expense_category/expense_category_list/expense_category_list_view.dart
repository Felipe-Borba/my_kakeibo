import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/card_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/icon_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/user/expense_category/expense_category_list/expense_category_list_view_model.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryListView extends StatelessWidget {
  const ExpenseCategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseCategoryListViewModel(
        context,
        context.read(),
      ),
      builder: (context, child) {
        final viewModel = Provider.of<ExpenseCategoryListViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarCustom(title: context.intl.expense_category),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => viewModel.onAdd(),
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                itemList(viewModel, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget itemList(
    ExpenseCategoryListViewModel viewModel,
    BuildContext context,
  ) {
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
    ExpenseCategory category,
    ExpenseCategoryListViewModel controller,
    BuildContext context,
  ) {
    return CardCustom(
      children: [
        const SizedBox(width: 16),
        Icon(category.icon.toIconData()),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(category.name, theme: CustomTheme.bodyMedium),
              TextCustom(
                category.color.getTranslation(context),
                theme: CustomTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () => controller.onEdit(category),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () async {
            var confirm = await showDeleteDialog(context,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextCustom(context.intl.confirmDeleteText),
                    const SizedBox(height: 16),
                    TextCustom(
                      context.intl.deleteRelatedExpenses,
                      theme: CustomTheme.labelSmall,
                    ),
                  ],
                ));
            if (confirm == true) {
              controller.onDelete(category);
            }
          },
        ),
      ],
    );
  }
}
