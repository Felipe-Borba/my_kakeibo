import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/mappers/color_custom_mapper.dart';

class InputFormColorCustom extends StatelessWidget {
  final ColorCustom? value;
  final String? Function(ColorCustom?)? validator;
  final void Function(ColorCustom?)? onChanged;

  const InputFormColorCustom({
    super.key,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ColorCustom?>(
      key: key,
      hint: Text(context.intl.color),
      value: value,
      onChanged: onChanged,
      items: ColorCustom.values.map((ColorCustom color) {
        return DropdownMenuItem(
          value: color,
          child: Text(color.getTranslation(context)),
        );
      }).toList(),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
