import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/formatter/currency_formatter.dart';

class InputFormCurrency extends StatefulWidget {
  final String? Function(double? value)? validator;
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
  State<InputFormCurrency> createState() => _InputFormCurrencyState();
}

class _InputFormCurrencyState extends State<InputFormCurrency> {
  late final controller = TextEditingController(
    text: widget.value != null ? context.currency.format(widget.value!) : '',
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [CurrencyFormatter(context)],
      decoration: InputDecoration(labelText: widget.labelText),
      validator: (String? text) {
        if (widget.validator == null) return null;

        if (text == null || text.isEmpty) {
          return widget.validator != null ? widget.validator!(null) : null;
        }

        double? amount = context.currency.tryParse(text)?.toDouble();
        return widget.validator!(amount);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(context.currency.parse(value).toDouble());
        }
      },
    );
  }
}
