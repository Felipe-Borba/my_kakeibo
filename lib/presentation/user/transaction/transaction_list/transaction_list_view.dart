import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_month.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/show_delete_dialog.dart';
import 'package:my_kakeibo/presentation/core/components/sort_component.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/date_time_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/screen_extension.dart';
import 'package:my_kakeibo/presentation/core/mappers/color_custom_mapper.dart';
import 'package:my_kakeibo/presentation/core/mappers/icon_custom_mapper.dart';
import 'package:my_kakeibo/presentation/user/transaction/transaction_list/transaction_list_view_model.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionListViewModel(
        context,
        context.read(),
        context.read(),
      ),
      builder: (context, child) {
        final viewModel = Provider.of<TransactionListViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.transactions,
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            context.intl.filters,
                            theme: CustomTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextCustom(context.intl.month),
                              InputMonth(
                                onMonthSelected: viewModel.setMonthFilter,
                                initialDate: viewModel.monthFilter,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextCustom(context.intl.sort),
                              SortComponent(
                                onSortChanged: viewModel.setSortBy,
                                sort: viewModel.sort,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            buttonSize: const Size.square(40),
            childrenButtonSize: const Size(40, 48),
            spacing: 8,
            spaceBetweenChildren: 8,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.add),
                backgroundColor: Colors.green,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                label: context.intl.income,
                onTap: () => viewModel.onAddIncome(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SpeedDialChild(
                child: const Icon(Icons.remove),
                backgroundColor: Colors.red,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                label: context.intl.expense,
                onTap: () => viewModel.onAddExpense(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                _buildTransactionTypeTabs(context, viewModel),
                const SizedBox(height: 8),
                _buildTransactionList(viewModel, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionTypeTabs(
    BuildContext context,
    TransactionListViewModel viewModel,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          _buildTabItem(
            context,
            context.intl.transactions,
            viewModel.selectedType == TransactionType.all,
            () => viewModel.setTransactionType(TransactionType.all),
          ),
          _buildTabItem(
            context,
            context.intl.income,
            viewModel.selectedType == TransactionType.income,
            () => viewModel.setTransactionType(TransactionType.income),
          ),
          _buildTabItem(
            context,
            context.intl.expense,
            viewModel.selectedType == TransactionType.expense,
            () => viewModel.setTransactionType(TransactionType.expense),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: isSelected
                  ? BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2)
                  : BorderSide.none,
            ),
          ),
          child: Center(
            child: TextCustom(
              title,
              theme: CustomTheme.bodyMedium,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              prominent: isSelected,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList(
    TransactionListViewModel viewModel,
    BuildContext context,
  ) {
    if (viewModel.filteredTransactions.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              TextCustom(
                context.intl.no_transactions,
                theme: CustomTheme.titleMedium,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        // padding: const EdgeInsets.only(top: 8, bottom: 80),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: viewModel.filteredTransactions.length,
        itemBuilder: (context, index) {
          var transaction = viewModel.filteredTransactions[index];
          return _buildTransactionItem(transaction, viewModel, context);
        },
      ),
    );
  }

  Widget _buildTransactionItem(
    Transaction transaction,
    TransactionListViewModel controller,
    BuildContext context,
  ) {
    return Slidable(
      key: ValueKey(transaction.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => controller.onEdit(transaction),
            backgroundColor: Colors.blue,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.edit,
            label: context.intl.edit,
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
                controller.onDelete(transaction);
              }
            },
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.delete,
            label: context.intl.delete,
          ),
        ],
      ),
      child: _transactionCard(context, transaction),
    );
  }

  Widget _transactionCard(BuildContext context, Transaction transaction) {
    return Stack(
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          shape: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          leading: Container(
            decoration: BoxDecoration(
              color: transaction is Expense
                  ? transaction.category.color.toColor().withOpacity(0.5)
                  : Colors.green.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              transaction is Expense
                  ? transaction.category.icon.toIconData()
                  : Icons.monetization_on_outlined,
            ),
          ),
          title: TextCustom(
            transaction is Income ? context.intl.income : context.intl.expense,
            theme: CustomTheme.titleMedium,
          ),
          subtitle: transaction.description.isNotEmpty
              ? TextCustom(
                  transaction.description,
                  theme: CustomTheme.bodyMedium,
                )
              : transaction is Expense
                  ? TextCustom(
                      transaction.category.name,
                      theme: CustomTheme.bodyMedium,
                    )
                  : transaction is Income
                      ? TextCustom(
                          transaction.source.name,
                          theme: CustomTheme.bodyMedium,
                        )
                      : null,
          trailing: Tooltip(
            preferBelow: false,
            message: context.currency.format(transaction.amount),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: context.screenPercentage(28),
                  ),
                  child: TextCustom(
                    context.currency.format(transaction.amount),
                    overflow: TextOverflow.ellipsis,
                    theme: CustomTheme.titleMedium,
                    textAlign: TextAlign.right,
                    color: transaction is Expense ? Colors.red : Colors.green,
                    prominent: true,
                  ),
                ),
                TextCustom(
                  transaction.date.formatToString(context),
                  theme: CustomTheme.bodyMedium,
                )
              ],
            ),
          ),
        ),
        const Positioned(
          right: -4,
          top: 0,
          bottom: 0,
          child: Icon(Icons.chevron_left, color: Colors.grey),
        ),
      ],
    );
  }
}
