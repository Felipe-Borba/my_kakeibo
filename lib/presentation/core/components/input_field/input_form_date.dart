import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

class InputFormDate extends StatefulWidget {
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
  State<InputFormDate> createState() => _InputFormDateState();
}

class _InputFormDateState extends State<InputFormDate> {
  late final intl = AppLocalizations.of(context)!;
  late final formatter = DateFormat.yMEd(context.locale.toString());
  late final controller = TextEditingController(
    text: widget.value != null ? formatter.format(widget.value!) : null,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      readOnly: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? text) {
        if (widget.validator == null) return null;

        if (text == null || text.isEmpty) {
          return widget.validator != null ? widget.validator!(null) : null;
        }

        DateTime? date = formatter.tryParse(text);
        return widget.validator!(date);
      },
      controller: controller,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (widget.onChanged != null) widget.onChanged!(pickedDate);
        if (pickedDate != null) controller.text = formatter.format(pickedDate);
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: intl.selectDate,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
    );
  }
}
