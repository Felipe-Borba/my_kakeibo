import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extentions/currency.dart';
import 'package:my_kakeibo/core/formatter/currency_formatter.dart';

class CurrencyFormField extends StatelessWidget {
  final String? Function(String? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final InputDecoration? decoration;
  final double? value;
  final void Function(double?)? onChanged;

  const CurrencyFormField({
    super.key,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.decoration,
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
      decoration: decoration,
      validator: validator,
      autovalidateMode: autovalidateMode,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(context.currency.parse(value).toDouble());
        }
      },
    );
  }
}
