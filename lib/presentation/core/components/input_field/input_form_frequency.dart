import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/frequency.dart';

class InputFormFrequency extends StatelessWidget {
  final Frequency? value;
  final String? Function(Frequency?)? validator;
  final void Function(Frequency?)? onChanged;

  const InputFormFrequency({
    super.key,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Frequency?>(
      key: key,
      hint: Text(context.intl.frequency),
      value: value,
      onChanged: onChanged,
      items: Frequency.values.map((Frequency category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.getTranslation(context)),
        );
      }).toList(),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
