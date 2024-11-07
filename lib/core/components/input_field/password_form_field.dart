import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String? value;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;

  const PasswordFormField({
    super.key,
    this.value,
    this.onChanged,
    this.decoration,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isPasswordVisible = false;

  togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      initialValue: widget.value,
      onChanged: widget.onChanged,
      obscureText: !isPasswordVisible,
      decoration: widget.decoration?.copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: togglePasswordVisibility,
        ),
      ),
    );
  }
}
