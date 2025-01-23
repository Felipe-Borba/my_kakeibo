import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/expense.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_currency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_date.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_expense_category.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/user/expense/expense_form/expense_form_controller.dart';
import 'package:provider/provider.dart';

class ExpenseFormView extends StatelessWidget {
  const ExpenseFormView({super.key, this.expense});

  final Expense? expense;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseFormController(context, expense),
      builder: (context, child) {
        final viewModel = Provider.of<ExpenseFormController>(context);

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
                  InputFormCurrency(
                    key: const Key("amount"),
                    value: viewModel.amount,
                    onChanged: viewModel.setAmount,
                    labelText: context.intl.amount,
                    validator: viewModel.validateAmount,
                  ),
                  const SizedBox(height: 8),
                  InputFormExpenseCategory(
                    key: const Key("category"),
                    value: viewModel.category,
                    onChanged: viewModel.setCategory,
                    validator: viewModel.validateCategory,
                  ),
                  const SizedBox(height: 8),
                  InputFormDate(
                    key: const Key("date"),
                    validator: viewModel.validateDate,
                    value: viewModel.date,
                    onChanged: viewModel.setDate,
                  ),
                  const SizedBox(height: 8),
                  InputFormString(
                    key: const Key("description"),
                    validator: viewModel.validateDescription,
                    labelText: context.intl.description,
                    initialValue: viewModel.description,
                    onChanged: viewModel.setDescription,
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
