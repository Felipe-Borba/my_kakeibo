import 'package:flutter/material.dart';

class TextTitleMedium extends StatelessWidget {
  final String data;
  final TextStyle? customTheme;

  const TextTitleMedium(this.data, {super.key, this.customTheme});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme.titleMedium;
    var finalTheme = customTheme != null ? theme?.merge(customTheme) : theme;

    return Text(data, style: finalTheme);
  }
}
