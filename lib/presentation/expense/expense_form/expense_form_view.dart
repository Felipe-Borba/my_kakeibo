import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/formatter/currency_formatter.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_controller.dart';

class ExpenseFormView extends StatelessWidget {
  const ExpenseFormView({super.key, this.expense});

  static const routeName = "/expense-form";

  final Expense? expense;

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ExpenseFormController>();

    return FutureBuilder(
      future: controller.loadInitialData(expense),
      builder: (context, snapshot) {
        return ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: const AppBarCustom(
                title: "Expense",
              ),
              body: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: const Key("amount"),
                        initialValue: controller.amount?.toString(),
                        onChanged: controller.setAmount,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CurrencyFormatter()],
                        decoration: const InputDecoration(labelText: "Amount"),
                        //TODO adicionar validacao
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<ExpenseCategory?>(
                        key: const Key("category"),
                        hint: const Text("Category"),
                        value: controller.category,
                        onChanged: controller.setCategory,
                        items: ExpenseCategory.values
                            .map((ExpenseCategory category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.toString().split('.').last),
                          );
                        }).toList(),
                        //TODO adicionar validacao
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        key: const Key("date"),
                        readOnly: true,
                        //TODO adicionar validacao
                        controller: TextEditingController(
                            text: controller.selectedDate != null
                                ? DateFormat.yMEd('pt_BR')
                                    .format(controller.selectedDate!)
                                : ""),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          controller.setSelectDate(pickedDate);
                        },
                        decoration: const InputDecoration(
                          hintText: "Select a Date",
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        key: const Key("description"),
                        //TODO adicionar validacao
                        initialValue: controller.description,
                        onChanged: controller.setDescription,
                        decoration:
                            const InputDecoration(labelText: "Description"),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          key: const Key("save-expense"),
                          onPressed: () => controller.onClickSave(context),
                          child: const Text("Save"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
