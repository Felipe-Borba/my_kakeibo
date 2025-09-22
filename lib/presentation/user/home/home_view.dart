import 'package:flutter/material.dart';
import 'package:my_kakeibo/app.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/domain/entity/transaction/transaction.dart';
import 'package:my_kakeibo/presentation/core/components/charts/life_bar.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_user.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/date_time_extension.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/screen_extension.dart';
import 'package:my_kakeibo/presentation/core/mappers/color_custom_mapper.dart';
import 'package:my_kakeibo/presentation/core/mappers/icon_custom_mapper.dart';
import 'package:my_kakeibo/presentation/user/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  late HomeViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //subscribe to route changes
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); //prevent memory leaks
    super.dispose();
  }

  @override
  void didPopNext() {
    _viewModel.getInitialData();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBar: const AppBarUser(),
      body: ChangeNotifierProvider(
        create: (context) => HomeViewModel(
          context.read(),
          context.read(),
          context.read(),
          context,
        ),
        builder: (BuildContext context, Widget? child) {
          _viewModel = Provider.of<HomeViewModel>(context);

          return Column(
            children: [
              summary(context, _viewModel),
              quickAccessBar(context, _viewModel),
              itemList(context, _viewModel),
            ],
          );
        },
      ),
    );
  }

  Widget summary(BuildContext context, HomeViewModel viewModel) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            // Theme.of(context).colorScheme.secondary,
            // Theme.of(context).colorScheme.onSecondaryContainer,
            Color(0xFF16A34A),
            Color(0xFF059669),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        context.intl.welcomeMessage(viewModel.user?.name ?? ""),
                        theme: CustomTheme.labelLarge,
                        color: Colors.white70,
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextCustom(
                        context.intl.welcome_back,
                        theme: CustomTheme.titleLarge,
                        prominent: true,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: viewModel.onSettingsPressed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            summaryInnerCard(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget summaryInnerCard(BuildContext context, HomeViewModel viewModel) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextCustom(
            context.intl.available,
            theme: CustomTheme.titleMedium,
            color: Colors.white,
          ),
          TextCustom(
            context.currency.format(viewModel.total),
            theme: CustomTheme.titleLarge,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(
                context.intl.income,
                theme: CustomTheme.titleMedium,
                color: Colors.white,
              ),
              TextCustom(
                context.currency.format(viewModel.totalIncome),
                theme: CustomTheme.titleMedium,
                color: Colors.white,
              ),
            ],
          ),
          LifeBar(
            total: viewModel.totalIncome,
            current: viewModel.total,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextCustom(
                "${context.intl.expense} ${context.currency.format(viewModel.totalExpense)}",
                prominent: true,
                theme: CustomTheme.labelMedium,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget quickAccessBar(BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextCustom(
            context.intl.quick_access,
            theme: CustomTheme.titleMedium,
            prominent: true,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              quickAccessBarButton(
                context: context,
                icon: Icons.add_circle_outline,
                label: context.intl.income,
                onPressed: viewModel.onAddIncomePressed,
                color: Colors.blueAccent,
              ),
              const SizedBox(width: 8),
              quickAccessBarButton(
                context: context,
                icon: Icons.remove_circle_outline_outlined,
                label: context.intl.expense,
                onPressed: viewModel.onAddExpensePressed,
                color: Colors.redAccent,
              ),
              const SizedBox(width: 8),
              quickAccessBarButton(
                context: context,
                icon: Icons.account_balance_wallet_outlined,
                label: context.intl.insights,
                onPressed: viewModel.onInsightsPressed,
                color: Colors.orangeAccent,
              ),
              const SizedBox(width: 8),
              quickAccessBarButton(
                context: context,
                icon: Icons.menu_outlined,
                label: context.intl.menu,
                onPressed: viewModel.onMenuPressed,
                color: Colors.blueGrey,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget quickAccessBarButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: theme.colorScheme.surfaceTint.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 4),
              TextCustom(label),
              const Expanded(child: SizedBox(height: 4)),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemList(BuildContext context, HomeViewModel viewModel) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  TextCustom(
                    context.intl.transactions,
                    theme: CustomTheme.titleMedium,
                    prominent: true,
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: viewModel.onSeeAllPressed,
                    child: Text(context.intl.seeAll),
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
            ? TextCustom(transaction.description, theme: CustomTheme.bodyMedium)
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
    );
  }
}
