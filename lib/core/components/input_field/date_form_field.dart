import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatelessWidget {
  final String? Function(String? value)? validator;
  final AutovalidateMode autovalidateMode;
  final InputDecoration decoration;
  final DateTime? value;
  final void Function(DateTime?)? onChanged;

  const DateFormField({
    super.key,
    this.validator,
    this.value,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.decoration = const InputDecoration(),
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMEd(
      Localizations.localeOf(context).toString(),
    );
    final controller = TextEditingController(
      text: value != null ? formatter.format(value!) : null,
    );

    return TextFormField(
      // key: key,
      readOnly: true,
      autovalidateMode: autovalidateMode,
      validator: validator,
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
      decoration: decoration.copyWith(
        hintText: "Select a Date",
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }
}
