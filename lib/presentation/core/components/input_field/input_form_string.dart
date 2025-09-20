import 'package:flutter/material.dart';

class InputFormString extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;

  const InputFormString({
    super.key,
    this.labelText,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
