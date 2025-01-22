import 'package:flutter/material.dart';

class TextBodyMedium extends StatelessWidget {
  final String data;

  const TextBodyMedium(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
