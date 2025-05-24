import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/icon_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';
import 'package:my_kakeibo/presentation/core/mappers/icon_custom_mapper.dart';

class InputFormIconCustom extends StatelessWidget {
  final IconCustom? value;
  final String? Function(IconCustom?)? validator;
  final void Function(IconCustom?)? onChanged;

  const InputFormIconCustom({
    super.key,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<IconCustom?>(
      key: key,
      hint: Text(context.intl.icon),
      value: value,
      onChanged: onChanged,
      items: IconCustom.values.map((IconCustom icon) {
        return DropdownMenuItem(
          value: icon,
          child: Row(
            children: [
              Icon(icon.toIconData()),
              const SizedBox(width: 8),
              Text(icon.getTranslation(context)),
            ],
          ),
        );
      }).toList(),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      menuMaxHeight: 200,
    );
  }
}
