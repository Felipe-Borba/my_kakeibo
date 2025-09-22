import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_filled.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_outline.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_currency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_date.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/body_form_layout.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_form_view_model.dart';
import 'package:provider/provider.dart';

class ExpenseFormView extends StatelessWidget {
  const ExpenseFormView({super.key, this.expense});

  final Expense? expense;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseFormViewModel(
        context,
        expense,
        context.read(),
      ),
      builder: (context, child) {
        final viewModel = Provider.of<ExpenseFormViewModel>(context);
        final validator = viewModel.validator;

        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.expense,
          ),
          body: BodyFormLayout(
            formKey: viewModel.validator.formKey,
            paddingTop: 18,
            title: expense == null
                ? context.intl.add_new_expense
                : context.intl.edit_expense,
            description: expense == null
                ? context.intl.add_new_expense_description
                : context.intl.edit_expense_description,
            formChildren: [
              InputFormCurrency(
                key: WidgetKeys.amount,
                value: viewModel.amount,
                onChanged: (value) => viewModel.amount = value,
                labelText: context.intl.amount,
                validator: validator.validateAmount,
              ),
              const SizedBox(height: 16),
              InputFormExpenseCategory(
                key: WidgetKeys.category,
                value: viewModel.category,
                onChanged: (value) => viewModel.category = value,
                validator: validator.validateCategory,
              ),
              const SizedBox(height: 16),
              InputFormDate(
                key: WidgetKeys.date,
                validator: validator.validateDate,
                value: viewModel.date,
                onChanged: (value) => viewModel.date = value,
              ),
              const SizedBox(height: 16),
              InputFormString(
                key: WidgetKeys.description,
                validator: validator.validateDescription,
                labelText: context.intl.description,
                initialValue: viewModel.description,
                onChanged: (value) => viewModel.description = value,
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
                  key: WidgetKeys.saveExpense,
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
