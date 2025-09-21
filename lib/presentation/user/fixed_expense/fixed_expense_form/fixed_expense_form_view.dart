import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/fixed_expense.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_filled.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_outline.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_currency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_date.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_frequency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_remember.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/body_form_layout.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';
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
          body: BodyFormLayout(
            formKey: viewModel.validator.formKey,
            paddingTop: 12,
            title: fixedExpense == null
                ? context.intl.add_new_fixed_expense
                : context.intl.edit_fixed_expense,
            description: fixedExpense == null
                ? context.intl.add_new_fixed_expense_description
                : context.intl.edit_fixed_expense_description,
            formChildren: [
              InputFormCurrency(
                key: WidgetKeys.amount,
                value: viewModel.amount,
                onChanged: (value) => viewModel.amount = value,
                labelText: context.intl.amount,
                validator: viewModel.validator.validateAmount,
              ),
              const SizedBox(height: 16),
              InputFormExpenseCategory(
                key: WidgetKeys.category,
                value: viewModel.category,
                onChanged: (value) => viewModel.category = value,
                validator: viewModel.validator.validateCategory,
              ),
              const SizedBox(height: 16),
              InputFormDate(
                key: WidgetKeys.dueDate,
                labelText: context.intl.dueDate,
                validator: viewModel.validator.validateDueDate,
                value: viewModel.dueDate,
                onChanged: (value) => viewModel.dueDate = value,
              ),
              const SizedBox(height: 16),
              InputFormFrequency(
                key: WidgetKeys.frequency,
                value: viewModel.frequency,
                onChanged: (value) => viewModel.frequency = value,
                validator: viewModel.validator.validateFrequency,
              ),
              const SizedBox(height: 16),
              InputFormString(
                key: WidgetKeys.description,
                validator: viewModel.validator.validateDescription,
                labelText: context.intl.description,
                initialValue: viewModel.description,
                onChanged: (value) => viewModel.description = value,
              ),
              const SizedBox(height: 16),
              InputFormRemember(
                key: WidgetKeys.remember,
                value: viewModel.remember,
                onChanged: (value) => viewModel.remember = value,
                validator: viewModel.validator.validateRemember,
              ),
            ],
            bottomChildren: [
              Expanded(
                child: ButtonOutline(
                  onPressed: () => Navigator.of(context).pop(),
                  text: context.intl.cancel,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ButtonFilled(
                  key: WidgetKeys.save,
                  onPressed: viewModel.onClickSave,
                  text: context.intl.save,
                  isLoading: viewModel.isLoading,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
