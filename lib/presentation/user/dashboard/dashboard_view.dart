import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/user/login/login_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LoginController>();

    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return const Scaffold(
          appBar: AppBarCustom(
            title: "Dashboard",
          ),
          body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Placeholder(),
          ),
        );
      },
    );
  }
}
