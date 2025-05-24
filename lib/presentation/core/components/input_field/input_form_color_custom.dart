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
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color.toColor(),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(color.getTranslation(context)),
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
