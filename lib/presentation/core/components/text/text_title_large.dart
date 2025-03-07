import 'package:flutter/material.dart';

@Deprecated('This class is deprecated. Use TextCustom instead.')
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
