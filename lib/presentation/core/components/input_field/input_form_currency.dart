import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/formatter/currency_formatter.dart';

class InputFormCurrency extends StatelessWidget {
  final String? Function(String? value)? validator;
  final String? labelText;
  final double? value;
  final void Function(double?)? onChanged;

  const InputFormCurrency({
    super.key,
    this.validator,
    this.labelText,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value?.toString());

    return TextFormField(
      key: key,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [CurrencyFormatter(context)],
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(context.currency.parse(value).toDouble());
        }
      },
    );
  }
}
