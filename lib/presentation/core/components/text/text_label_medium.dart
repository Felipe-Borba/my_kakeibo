import 'package:flutter/material.dart';

class TextLabelMedium extends StatelessWidget {
  final String data;
  final bool prominent;

  const TextLabelMedium(this.data, {super.key, this.prominent = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme.labelMedium;
    return Text(
      data,
      style: prominent ? theme!.copyWith(fontWeight: FontWeight.bold) : theme,
    );
  }
}
