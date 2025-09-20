import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_filled.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_outline.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_color_custom.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_icon_custom.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/body_form_layout.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';
import 'package:my_kakeibo/presentation/user/expense_category/expense_category_form/expense_category_form_view_model.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryFormView extends StatelessWidget {
  const ExpenseCategoryFormView({super.key, this.expenseCategory});

  final ExpenseCategory? expenseCategory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseCategoryFormViewModel(
        context,
        expenseCategory,
        context.read(),
      ),
      builder: (context, child) {
        final viewModel = Provider.of<ExpenseCategoryFormViewModel>(context);
        final validator = viewModel.validator;

        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.expense_category,
          ),
          body: BodyFormLayout(
            key: viewModel.validator.formKey,
            paddingTop: 18,
            title: expenseCategory == null
                ? context.intl.add_new_expense_category
                : context.intl.edit_expense_category,
            description: expenseCategory == null
                ? context.intl.add_new_expense_category_description
                : context.intl.edit_expense_category_description,
            formChildren: [
              InputFormString(
                key: WidgetKeys.name,
                validator: validator.validateName,
                labelText: context.intl.name,
                initialValue: viewModel.name,
                onChanged: (value) => viewModel.name = value,
              ),
              const SizedBox(height: 16),
              InputFormColorCustom(
                key: WidgetKeys.color,
                validator: validator.validateColor,
                value: viewModel.color,
                onChanged: (value) => viewModel.color = value,
              ),
              const SizedBox(height: 16),
              InputFormIconCustom(
                key: WidgetKeys.icon,
                validator: validator.validateIcon,
                value: viewModel.icon,
                onChanged: (value) => viewModel.icon = value,
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
