import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_filled.dart';
import 'package:my_kakeibo/presentation/core/components/button/button_outline.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_currency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_date.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_income_source.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/body_form_layout.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';
import 'package:my_kakeibo/presentation/user/income/income_form/income_form_view_model.dart';
import 'package:provider/provider.dart';

class IncomeFormView extends StatelessWidget {
  const IncomeFormView({super.key, this.income});

  final Income? income;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeFormViewModel(context, income, context.read()),
      builder: (context, child) {
        final viewModel = Provider.of<IncomeFormViewModel>(context);
        final validator = viewModel.validator;

        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.income,
          ),
          body: BodyFormLayout(
            key: viewModel.validator.formKey,
            paddingTop: 18,
            title: income == null
                ? context.intl.add_new_income
                : context.intl.edit_income,
            description: income == null
                ? context.intl.add_new_income_description
                : context.intl.edit_income_description,
            formChildren: [
              InputFormCurrency(
                key: WidgetKeys.amount,
                value: viewModel.amount,
                onChanged: (value) => viewModel.amount = value,
                labelText: context.intl.amount,
                validator: validator.validateAmount,
              ),
              const SizedBox(height: 16),
              InputFormIncomeSource(
                key: WidgetKeys.source,
                value: viewModel.source,
                onChanged: (value) => viewModel.source = value,
                validator: validator.validateSource,
              ),
              const SizedBox(height: 16),
              InputFormDate(
                key: WidgetKeys.date,
                value: viewModel.date,
                onChanged: (value) => viewModel.date = value,
                validator: validator.validateDate,
              ),
              const SizedBox(height: 16),
              InputFormString(
                key: WidgetKeys.description,
                initialValue: viewModel.description,
                onChanged: (value) => viewModel.description = value,
                validator: validator.validateDescription,
                labelText: context.intl.description,
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
