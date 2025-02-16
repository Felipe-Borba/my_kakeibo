import 'package:flutter/material.dart';

class TextTitleLarge extends StatelessWidget {
  final String data;
  final TextStyle? customTheme;

  const TextTitleLarge(
    this.data, {
    super.key,
    this.customTheme,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme.titleLarge;
    var finalTheme = customTheme != null ? theme?.merge(customTheme) : theme;

    return Text(data, style: finalTheme);
  }
}
