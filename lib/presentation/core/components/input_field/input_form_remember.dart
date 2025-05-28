import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/fixed_expense/remember.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/mappers/remember_mapper.dart';

class InputFormRemember extends StatelessWidget {
  final Remember? value;
  final String? Function(Remember?)? validator;
  final void Function(Remember?)? onChanged;

  const InputFormRemember({
    super.key,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Remember?>(
      key: key,
      hint: Text(context.intl.remember),
      value: value,
      onChanged: onChanged,
      items: Remember.values.map((Remember remember) {
        return DropdownMenuItem(
          value: remember,
          child: Text(remember.getTranslation(context)),
        );
      }).toList(),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
