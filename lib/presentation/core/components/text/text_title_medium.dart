import 'package:flutter/material.dart';

class TextTitleMedium extends StatelessWidget {
  final String data;

  const TextTitleMedium(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
