import 'package:flutter/material.dart';

class TextTitleLarge extends StatelessWidget {
  final String data;

  const TextTitleLarge(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
