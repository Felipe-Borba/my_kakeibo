import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';

class LifeBar extends StatelessWidget {
  final double total;
  final double current;

  const LifeBar({
    super.key = WidgetKeys.lifeBar,
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
          minHeight: 8,
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
