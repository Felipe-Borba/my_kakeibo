import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/currency_form_field.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/date_form_field.dart';
import 'package:my_kakeibo/presentation/core/components/keyboard_aware.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_form/fixed_expense_form_controller.dart';
import 'package:provider/provider.dart';

class FixedExpenseFormView extends StatelessWidget {
  const FixedExpenseFormView({super.key, this.fixedExpense});

  final FixedExpense? fixedExpense;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FixedExpenseFormController(context, fixedExpense),
      builder: (context, child) {
        final controller = Provider.of<FixedExpenseFormController>(context);
        final intl = AppLocalizations.of(context)!;

        return KeyboardAware(
          child: Scaffold(
            appBar: AppBarCustom(title: intl.fixedExpense),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                child: Center(
                  child: formView(controller, intl, context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Form formView(
    FixedExpenseFormController controller,
    AppLocalizations intl,
    BuildContext context,
  ) {
    return Form(
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
            items: ExpenseCategory.values.map((ExpenseCategory category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.getTranslation(context)),
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
          DropdownButtonFormField<Frequency?>(
            key: const Key("frequency"),
            hint: Text(intl.frequency),
            value: controller.frequency,
            onChanged: (value) => controller.frequency = value,
            items: Frequency.values.map((Frequency category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.getTranslation(context)),
              );
            }).toList(),
            validator: controller.validateFrequency,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
    );
  }
}
