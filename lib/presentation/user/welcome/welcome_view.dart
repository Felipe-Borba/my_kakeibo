import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/onboarding/welcome/welcome_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WelcomeController(),
      builder: (context, child) {
        final controller = Provider.of<WelcomeController>(context);
        final intl = AppLocalizations.of(context)!;

        return Scaffold(
          // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                ClipOval(child: Image.asset("assets/launcher/icon.png")),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: Text(
                    intl.welcomeToOurFinanceApp,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Text(
                    intl.manageYourFinancesWithEase,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Text(
                    intl.trackYourExpensesSetBudgets,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: ElevatedButton(
                    onPressed: controller.onContinue,
                    child: Text(intl.getStarted),
                  ),
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
