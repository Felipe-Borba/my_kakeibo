import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/mappers/color_custom_mapper.dart';
import 'package:my_kakeibo/presentation/core/mappers/icon_custom_mapper.dart';
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
        context.read(),
      ),
      builder: (context, child) {
        final viewModel = Provider.of<ExpenseCategoryListViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.expense_category,
          ),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => viewModel.onAdd(),
            elevation: 4,
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                TextCustom(
                  context.intl.expense_category,
                  theme: CustomTheme.headlineSmall,
                  prominent: true,
                ),
                TextCustom(
                  context.intl.slide_to_edit_or_delete,
                  theme: CustomTheme.bodySmall,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                // List
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
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category_outlined,
                size: 64,
                color: Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              TextCustom(
                context.intl.no_expenses,
                theme: CustomTheme.titleMedium,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: viewModel.list.length,
        itemBuilder: (context, index) {
          var category = viewModel.list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: item(category, viewModel, context),
          );
        },
      ),
    );
  }

  Widget item(
    ExpenseCategory category,
    ExpenseCategoryListViewModel controller,
    BuildContext context,
  ) {
    return Slidable(
      key: ValueKey(category.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => controller.onEdit(category),
            backgroundColor: Colors.blue,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.edit,
            label: context.intl.edit,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          SlidableAction(
            onPressed: (_) async {
              var confirm = await showDeleteDialog(
                context,
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
                ),
              );
              if (confirm == true) {
                controller.onDelete(category);
              }
            },
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.delete,
            label: context.intl.delete,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
        ],
      ),
      // Conteúdo principal do item
      child: Card.outlined(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color:
                Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              // Ícone com fundo colorido
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: category.color.toColor().withOpacity(0.2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category.icon.toIconData(),
                  color: category.color.toColor(),
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              // Informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      category.name,
                      theme: CustomTheme.titleSmall,
                      prominent: true,
                    ),
                    const SizedBox(height: 4),
                    TextCustom(
                      context.intl.expenseCount(
                        controller.expenseCountByCategory[category.id] ?? 0,
                      ),
                      theme: CustomTheme.bodyMedium,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
              // Indicador de deslizamento
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 16,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
