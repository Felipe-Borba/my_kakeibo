import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/formatter/currency_formatter.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/expense/expense_form/expense_form_controller.dart';
import 'package:provider/provider.dart';

class ExpenseFormView extends StatelessWidget {
  const ExpenseFormView({super.key, this.expense});

  static const routeName = "/expense-form";

  final Expense? expense;
  //TODO esse exemplo de view acho que virou o meu novo padrão para seguir para implementar qualquer outra tela, para validar tenho que ir trocando as outras para ver se encaixa bem.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseFormController(context, expense),
      builder: (context, child) {
        final controller = Provider.of<ExpenseFormController>(context);

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
                    controller: controller.amountController,
                    //TODO de certa forma aqui tb, visto que eu sempre esqueço o keyboard certo e existe umas gambi de parse de valor lá no controller
                    keyboardType: TextInputType.number,
                    inputFormatters: [CurrencyFormatter(context)],
                    decoration: const InputDecoration(labelText: "Amount"),
                    validator: controller.validateAmount,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<ExpenseCategory?>(
                    key: const Key("category"),
                    hint: const Text("Category"),
                    value: controller.getCategory(),
                    onChanged: controller.setCategory,
                    items:
                        ExpenseCategory.values.map((ExpenseCategory category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.toString().split('.').last),
                      );
                    }).toList(),
                    validator: controller.validateCategory,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    //TODO penso em mover isso para um componente isolado já que ele é bem propício para ser reutilizado e tem aspectos fáceis de esquecer como o icone certo, as malandragem no controller etc...
                    key: const Key("date"),
                    readOnly: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: controller.validateDate,
                    controller: controller.dataController,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      controller.setDate(pickedDate);
                    },
                    decoration: const InputDecoration(
                      hintText: "Select a Date",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: const Key("description"),
                    validator: controller.validateDescription,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: "Description"),
                    controller: controller.descriptionController,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      key: const Key("save-expense"),
                      onPressed: controller.onClickSave,
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
  }
}
