import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/input_field/currency_form_field.dart';
import 'package:my_kakeibo/core/components/input_field/date_form_field.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/fixed_expense/fixed_expense_form/fixed_expense_form_controller.dart';
import 'package:provider/provider.dart';

class FixedExpenseFormView extends StatelessWidget {
  const FixedExpenseFormView({super.key, this.fixedExpense});

  static const routeName = "/fixed-expense-form";

  final FixedExpense? fixedExpense;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FixedExpenseFormController(context, fixedExpense),
      builder: (context, child) {
        final controller = Provider.of<FixedExpenseFormController>(context);
        final intl = AppLocalizations.of(context)!;

        return Scaffold(
          appBar: AppBarCustom(title: intl.fixedExpense),
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CurrencyFormField(
                    key: const Key("amount"),
                    value: controller.amount,
                    onChanged: controller.setAmount,
                    decoration: InputDecoration(labelText: intl.amount),
                    validator: controller.validateAmount,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<ExpenseCategory?>(
                    key: const Key("category"),
                    hint: Text(intl.category),
                    value: controller.category,
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
                  DateFormField(
                    decoration: InputDecoration(
                      labelText: intl.dueDate,
                    ),
                    key: const Key("dueDate"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: controller.validateDueDate,
                    value: controller.dueDate,
                    onChanged: controller.setDueDate,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: const Key("description"),
                    validator: controller.validateDescription,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(labelText: intl.description),
                    initialValue: controller.description,
                    onChanged: controller.setDescription,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      key: const Key("save-expense"),
                      onPressed: controller.onClickSave,
                      child: Text(intl.save),
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
