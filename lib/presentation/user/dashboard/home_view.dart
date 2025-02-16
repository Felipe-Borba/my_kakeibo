import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/date_time_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/icon_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/presentation/core/components/charts/life_bar.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_body_medium.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_label_medium.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_title_large.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_title_medium.dart';
import 'package:my_kakeibo/presentation/core/extensions/screen_extension.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = Provider.of<DashboardViewModel>(context);
    viewModel.getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DashboardViewModel>(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: Column(
        children: [
          summary(context, viewModel),
          itemList(context, viewModel),
        ],
      ),
    );
  }

  Widget summary(BuildContext context, DashboardViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitleMedium(context.intl.available),
          TextTitleLarge(context.currency.format(viewModel.total)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextTitleMedium(context.intl.income),
              TextTitleMedium(context.currency.format(viewModel.totalIncome)),
            ],
          ),
          LifeBar(
            total: viewModel.totalIncome,
            current: viewModel.total,
          ),
          const SizedBox(height: 4),
          TextLabelMedium(
            "${context.intl.expense} ${context.currency.format(viewModel.totalExpense)}",
            prominent: true,
          ),
        ],
      ),
    );
  }

  Widget itemList(BuildContext context, DashboardViewModel viewModel) {
    if (viewModel.list.isEmpty) {
      return Expanded(child: Center(child: Text(context.intl.no_transactions)));
    }
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 32),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16),
          ),
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  TextTitleMedium(context.intl.transactions),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {},
                    child: const SizedBox(),
                    // child: Text(context.intl.seeAll),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.list.length,
                  itemBuilder: (context, index) {
                    var transaction = viewModel.list[index];
                    return item(transaction, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(Transaction transaction, BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.all(4),
      child: ListTile(
        leading: Icon(
          transaction is Expense
              ? transaction.category.icon.toIconData()
              : Icons.monetization_on_outlined,
        ),
        title: TextTitleMedium(
          transaction is Income ? context.intl.income : context.intl.expense,
        ),
        subtitle: transaction.description.isNotEmpty
            ? TextBodyMedium(transaction.description)
            : transaction is Expense
                ? TextBodyMedium(transaction.category.name)
                : transaction is Income
                    ? TextBodyMedium(transaction.source.name)
                    : null,
        trailing: Tooltip(
          preferBelow: false,
          message: context.currency.format(transaction.amount),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints:
                    BoxConstraints(maxWidth: context.screenPercentage(28),),
                child: TextTitleMedium(
                  context.currency.format(transaction.amount),
                  customTheme: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
              TextBodyMedium(
                transaction.date.formatToString(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
