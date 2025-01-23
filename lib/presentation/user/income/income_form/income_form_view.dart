import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/currency_form_field.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/date_form_field.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/input_form_string.dart';
import 'package:my_kakeibo/presentation/core/components/layout/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/layout/scaffold_custom.dart';
import 'package:my_kakeibo/presentation/user/income/income_form/income_form_controller.dart';
import 'package:provider/provider.dart';

class IncomeFormView extends StatelessWidget {
  const IncomeFormView({super.key, this.income});

  final Income? income;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeFormController(context, income),
      builder: (context, child) {
        final viewModel = Provider.of<IncomeFormController>(context);

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
                  CurrencyFormField(
                    key: const Key("amount"),
                    value: viewModel.amount,
                    onChanged: viewModel.setAmount,
                    decoration: InputDecoration(
                      labelText: context.intl.amount,
                    ),
                    validator: viewModel.validateAmount,
                  ),
                  const SizedBox(height: 8),
                  DateFormField(
                    key: const Key("date"),
                    value: viewModel.date,
                    onChanged: viewModel.setDate,
                    validator: viewModel.validateDate,
                  ),
                  const SizedBox(height: 8),
                  InputFormString(
                    key: const Key("description"),
                    initialValue: viewModel.description,
                    onChanged: viewModel.setDescription,
                    validator: viewModel.validateDescription,
                    labelText: context.intl.description,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      key: const Key("save-income"),
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
