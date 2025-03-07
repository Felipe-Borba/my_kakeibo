import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String data;
  final bool prominent;
  final CustomTheme theme;
  final TextOverflow? overflow;
  final Color? color;
  final TextAlign? textAlign;

  const TextCustom(
    this.data, {
    super.key,
    this.prominent = false,
    this.theme = CustomTheme.bodyLarge,
    this.overflow,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow: overflow,
      textAlign: textAlign,
      style: _getTextStyle(context, theme)!,
    );
  }

  TextStyle? _getTextStyle(BuildContext context, CustomTheme theme) {
    TextStyle? baseStyle = Theme.of(context).textTheme.bodyLarge;

    baseStyle = switch (theme) {
      CustomTheme.bodySmall => Theme.of(context).textTheme.bodySmall,
      CustomTheme.bodyMedium => Theme.of(context).textTheme.bodyMedium,
      CustomTheme.bodyLarge => Theme.of(context).textTheme.bodyLarge,
      CustomTheme.labelSmall => Theme.of(context).textTheme.labelSmall,
      CustomTheme.labelMedium => Theme.of(context).textTheme.labelMedium,
      CustomTheme.labelLarge => Theme.of(context).textTheme.labelLarge,
      CustomTheme.titleSmall => Theme.of(context).textTheme.titleSmall,
      CustomTheme.titleMedium => Theme.of(context).textTheme.titleMedium,
      CustomTheme.titleLarge => Theme.of(context).textTheme.titleLarge,
      CustomTheme.headlineSmall => Theme.of(context).textTheme.headlineSmall,
      CustomTheme.headlineMedium => Theme.of(context).textTheme.headlineMedium,
      CustomTheme.headlineLarge => Theme.of(context).textTheme.headlineLarge,
      CustomTheme.displaySmall => Theme.of(context).textTheme.displaySmall,
      CustomTheme.displayMedium => Theme.of(context).textTheme.displayMedium,
      CustomTheme.displayLarge => Theme.of(context).textTheme.displayLarge,
    };

    if (color != null) {
      baseStyle = baseStyle?.copyWith(color: color);
    }
    if (prominent) {
      baseStyle = baseStyle?.copyWith(fontWeight: FontWeight.bold);
    }

    return baseStyle;
  }
}

enum CustomTheme {
  bodySmall,
  bodyMedium,
  bodyLarge,
  labelSmall,
  labelMedium,
  labelLarge,
  titleSmall,
  titleMedium,
  titleLarge,
  headlineSmall,
  headlineMedium,
  headlineLarge,
  displaySmall,
  displayMedium,
  displayLarge,
}
