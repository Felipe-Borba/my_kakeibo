import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_controller.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WelcomeController(context),
      builder: (context, child) {
        final viewModel = Provider.of<WelcomeController>(context);

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
                Text(
                  '${context.intl.appTitle} 家計簿',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: Text(
                    context.intl.welcomeToOurFinanceApp,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Text(
                    context.intl.manageYourFinancesWithEase,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Text(
                    context.intl.trackYourExpensesSetBudgets,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
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
