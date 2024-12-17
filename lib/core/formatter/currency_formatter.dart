import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_kakeibo/core/extensions/currency.dart';

class CurrencyFormatter extends TextInputFormatter {
  CurrencyFormatter(this._context);

  final BuildContext _context;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (filteredText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value = double.parse(filteredText) / 100;

    final formattedText = _context.currency.format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
