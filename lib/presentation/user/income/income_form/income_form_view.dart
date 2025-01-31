import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_income_source.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_currency.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_date.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
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

        return ScaffoldCustom(
          appBar: AppBarCustom(
            title: context.intl.income,
          ),
          body: Form(
            key: viewModel.formKey,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputFormCurrency(
                    key: WidgetKeys.amount,
                    value: viewModel.amount,
                    onChanged: (value) => viewModel.amount = value,
                    labelText: context.intl.amount,
                    validator: viewModel.validateAmount,
                  ),
                  const SizedBox(height: 8),
                  InputFormIncomeSource(
                    key: WidgetKeys.source,
                    value: viewModel.source,
                    onChanged: (value) => viewModel.source = value,
                    validator: viewModel.validateSource,
                  ),
                  const SizedBox(height: 8),
                  InputFormDate(
                    key: WidgetKeys.date,
                    value: viewModel.date,
                    onChanged: (value) => viewModel.date = value,
                    validator: viewModel.validateDate,
                  ),
                  const SizedBox(height: 8),
                  InputFormString(
                    key: WidgetKeys.description,
                    initialValue: viewModel.description,
                    onChanged: (value) => viewModel.description = value,
                    validator: viewModel.validateDescription,
                    labelText: context.intl.description,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      key: WidgetKeys.save,
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
