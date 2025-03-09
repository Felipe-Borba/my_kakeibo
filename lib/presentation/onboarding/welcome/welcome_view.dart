import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_view_model.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WelcomeViewModel(context),
      builder: (context, child) {
        final viewModel = Provider.of<WelcomeViewModel>(context);

        return ScaffoldCustom(
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                ClipOval(child: Image.asset("assets/launcher/icon.png")),
                const Expanded(child: SizedBox()),
                TextCustom(
                  '${context.intl.appTitle} 家計簿',
                  color: Colors.grey[800],
                  theme: CustomTheme.bodyLarge,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: TextCustom(
                    context.intl.welcomeToOurFinanceApp,
                    textAlign: TextAlign.center,
                    theme: CustomTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: TextCustom(
                    context.intl.manageYourFinancesWithEase,
                    theme: CustomTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: TextCustom(
                    context.intl.trackYourExpensesSetBudgets,
                    textAlign: TextAlign.center,
                    theme: CustomTheme.bodyLarge,
                  ),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                  onPressed: viewModel.termsAndPrivacyClick,
                  child: Text(
                    context.intl.agreement_warning,
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: viewModel.onContinue,
                  child: Text(context.intl.getStarted),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        );
      },
    );
  }
}
