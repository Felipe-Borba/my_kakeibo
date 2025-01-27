import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_color_custom.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_icon_custom.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/user/expense_category/expense_category_form/expense_category_form_view_model.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryFormView extends StatelessWidget {
  const ExpenseCategoryFormView({super.key, this.expenseCategory});

  final ExpenseCategory? expenseCategory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ExpenseCategoryFormViewModel(context, expenseCategory),
      builder: (context, child) {
        final viewModel = Provider.of<ExpenseCategoryFormViewModel>(context);

        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.expense,
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  InputFormString(
                    key: const Key("name"),
                    validator: viewModel.validateName,
                    labelText: context.intl.name,
                    initialValue: viewModel.name,
                    onChanged: (value) => viewModel.name = value,
                  ),
                  const SizedBox(height: 8),
                  InputFormColorCustom(
                    key: const Key("color"),
                    validator: viewModel.validateColor,
                    value: viewModel.color,
                    onChanged: (value) => viewModel.color = value,
                  ),
                  const SizedBox(height: 8),
                  InputFormIconCustom(
                    key: const Key("icon"),
                    validator: viewModel.validateIcon,
                    value: viewModel.icon,
                    onChanged: (value) => viewModel.icon = value,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      key: const Key("save-expense"),
                      onPressed: viewModel.onClickSave,
                      child: Text(context.intl.save),
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
