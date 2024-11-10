import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/welcome/welcome_controller.dart';
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
                Image.network(
                  'https://images.unsplash.com/photo-1641979319851-a8ed7ed67314?w=1280&h=720',
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: Text(intl.welcomeToOurFinanceApp),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Text(intl.manageYourFinancesWithEase),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Text(intl.trackYourExpensesSetBudgets),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: ElevatedButton(
                    onPressed: controller.onContinue,
                    child: Text(intl.getStarted),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
