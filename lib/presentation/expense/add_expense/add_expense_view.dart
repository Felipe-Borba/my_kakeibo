import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/presentation/expense/add_expense/add_expense_controller.dart';

class AddExpenseView extends StatelessWidget {
  const AddExpenseView({super.key});

  static const routeName = '/expense/add';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AddExpenseController>();

    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return const Scaffold(
          appBar: AppBarCustom(
            title: "Expense",
          ),
          drawer: DrawerCustom(),
          body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Placeholder(),
          ),
        );
      },
    );
  }
}
