import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

class InputFormDate extends StatelessWidget {
  final String? Function(DateTime? value)? validator;
  final String? labelText;
  final DateTime? value;
  final void Function(DateTime?)? onChanged;

  const InputFormDate({
    super.key,
    this.validator,
    this.value,
    this.onChanged,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final intl = AppLocalizations.of(context)!;
    final formatter = DateFormat.yMEd(context.locale.toString());
    final controller = TextEditingController(
      text: value != null ? formatter.format(value!) : null,
    );

    return TextFormField(
      // key: key,
      readOnly: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? text) {
        if (validator != null) return null;

        if (text == null || text.isEmpty) {
          return validator != null ? validator!(null) : null;
        }

        DateTime? date = formatter.tryParse(text);
        return validator!(date);
      },
      controller: controller,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (onChanged != null) onChanged!(pickedDate);
        if (pickedDate != null) controller.text = formatter.format(pickedDate);
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: intl.selectDate,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
    );
  }
}
