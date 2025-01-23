import 'package:flutter/material.dart';

class TextBodyMedium extends StatelessWidget {
  final String data;
  final bool prominent;

  const TextBodyMedium(
    this.data, {
    super.key,
    this.prominent = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyMedium;
    return Text(
      data,
      style: prominent ? theme!.copyWith(fontWeight: FontWeight.bold) : theme,
    );
  }
}
