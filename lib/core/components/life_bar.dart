import 'package:flutter/material.dart';

class LifeBar extends StatelessWidget {
  final double total;
  final double current;

  LifeBar({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = 0;
    if (total != 0) {
      percentage = current / total;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.red,
          color: Colors.green,
          minHeight: 10,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        // Text(
        //   context.currency.format(current),
        //   style: const TextStyle(
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ],
    );
  }
}
