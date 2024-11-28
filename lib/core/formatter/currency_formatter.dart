import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  CurrencyFormatter(this._context);

  final BuildContext _context;

  late final NumberFormat formatter = NumberFormat.currency(
    locale: Localizations.localeOf(_context).toString(),
    symbol: '',
    decimalDigits: 2,
  );

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

    final formattedText = formatter.format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
