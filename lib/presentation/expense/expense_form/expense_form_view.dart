import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_controller.dart';

class ExpenseFormView extends StatelessWidget {
  const ExpenseFormView({super.key, this.id});

  static const routeName = '/expense/:id';

  final String? id;

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ExpenseFormController>();

    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: const AppBarCustom(
            title: "Expense",
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
                DropdownButton<ExpenseCategory?>(
                  key: const Key("category"),
                  hint: const Text("Category"),
                  value: controller.category,
                  onChanged: controller.onSelectCategory,
                  items: ExpenseCategory.values.map((ExpenseCategory category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.toString().split('.').last),
                    );
                  }).toList(),
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
                    key: const Key("save-expense"),
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
