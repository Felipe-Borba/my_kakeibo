import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_kakeibo/presentation/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/currency_form_field.dart';
import 'package:my_kakeibo/presentation/core/components/input_field/date_form_field.dart';
import 'package:my_kakeibo/domain/entity/transaction/income.dart';
import 'package:my_kakeibo/presentation/income/income_form/income_form_controller.dart';
import 'package:provider/provider.dart';

class IncomeFormView extends StatelessWidget {
  const IncomeFormView({super.key, this.income});

  final Income? income;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncomeFormController(context, income),
      builder: (context, child) {
        final controller = Provider.of<IncomeFormController>(context);
        final intl = AppLocalizations.of(context)!;

        return ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: AppBarCustom(
                title: intl.income,
              ),
              body: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CurrencyFormField(
                        key: const Key("amount"),
                        value: controller.amount,
                        onChanged: controller.setAmount,
                        decoration: InputDecoration(
                          labelText: intl.amount,
                        ),
                        validator: controller.validateAmount,
                      ),
                      const SizedBox(height: 8),
                      DateFormField(
                        key: const Key("date"),
                        value: controller.date,
                        onChanged: controller.setDate,
                        validator: controller.validateDate,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        key: const Key("description"),
                        initialValue: controller.description,
                        onChanged: controller.setDescription,
                        validator: controller.validateDescription,
                        decoration: InputDecoration(
                          labelText: intl.description,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          key: const Key("save-income"),
                          onPressed: controller.onClickSave,
                          child: Text(intl.save),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
