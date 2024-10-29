import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_controller.dart';

class IncomeFormView extends StatelessWidget {
  const IncomeFormView({super.key, this.id});

  static const routeName = '/income/:id';

  final String? id;

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<IncomeFormController>();

    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: const AppBarCustom(
            title: "Income",
          ),
          drawer: const DrawerCustom(),
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  key: const Key("amount"),
                  controller: controller.amount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: "Amount",
                    errorText: controller.amountError,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  key: const Key("date"),
                  controller: controller.dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select a Date",
                    errorText: controller.dateError,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => controller.onSelectDate(context),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  key: const Key("description"),
                  controller: controller.description,
                  decoration: InputDecoration(
                    labelText: "Description",
                    errorText: controller.descriptionError,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    key: const Key("save-income"),
                    onPressed: () =>
                        controller.onClickSave(context: context, id: id),
                    child: const Text("Save"),
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
