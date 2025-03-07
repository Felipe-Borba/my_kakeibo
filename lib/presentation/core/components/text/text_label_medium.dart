import 'package:flutter/material.dart';

@Deprecated('This class is deprecated. Use TextCustom instead.')
class TextLabelMedium extends StatelessWidget {
  final String data;
  final bool prominent; 
  final TextStyle? customTheme;

  const TextLabelMedium(
    this.data, {
    super.key,
    this.prominent = false,
    this.customTheme,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme.labelMedium;
    var finalTheme = customTheme != null ? theme?.merge(customTheme) : theme;

    return Text(
      data,
      style: prominent
          ? finalTheme?.copyWith(fontWeight: FontWeight.bold)
          : finalTheme,
    );
  }
}
