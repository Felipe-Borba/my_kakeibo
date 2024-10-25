import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/user/login/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LoginController>();
    final intl = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: AppBarCustom(
            title: intl.welcome,
          ),
          body: const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Placeholder(),
          ),
        );
      },
    );
  }
}
