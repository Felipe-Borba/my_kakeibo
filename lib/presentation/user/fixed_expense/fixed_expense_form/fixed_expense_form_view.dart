import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_currency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_date.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_frequency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/user/fixed_expense/fixed_expense_form/fixed_expense_form_view_model.dart';
import 'package:provider/provider.dart';

class FixedExpenseFormView extends StatelessWidget {
  const FixedExpenseFormView({super.key, this.fixedExpense});

  final FixedExpense? fixedExpense;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FixedExpenseFormViewModel(
        context,
        fixedExpense,
        context.read(),
      ),
      builder: (context, child) {
        final viewModel = Provider.of<FixedExpenseFormViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarCustom(title: context.intl.fixedExpense),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
              child: Center(
                child: formView(viewModel, context),
              ),
            ),
          ),
        );
      },
    );
  }

  Form formView(
    FixedExpenseFormViewModel controller,
    BuildContext context,
  ) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputFormCurrency(
            key: const Key("amount"),
            value: controller.amount,
            onChanged: controller.setAmount,
            labelText: context.intl.amount,
            validator: controller.validateAmount,
          ),
          const SizedBox(height: 8),
          InputFormExpenseCategory(
            key: const Key("category"),
            value: controller.category,
            onChanged: controller.setCategory,
            validator: controller.validateCategory,
          ),
          const SizedBox(height: 8),
          InputFormDate(
            key: const Key("dueDate"),
            labelText: context.intl.dueDate,
            validator: controller.validateDueDate,
            value: controller.dueDate,
            onChanged: controller.setDueDate,
          ),
          const SizedBox(height: 8),
          InputFormFrequency(
            key: const Key("frequency"),
            value: controller.frequency,
            onChanged: (value) => controller.frequency = value,
            validator: controller.validateFrequency,
          ),
          const SizedBox(height: 8),
          InputFormString(
            key: const Key("description"),
            validator: controller.validateDescription,
            labelText: context.intl.description,
            initialValue: controller.description,
            onChanged: controller.setDescription,
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              key: const Key("save-expense"),
              onPressed: controller.onClickSave,
              child: Text(context.intl.save),
            ),
          ),
        ],
      ),
    );
  }
}
