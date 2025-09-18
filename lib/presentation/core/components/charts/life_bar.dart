import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/widget_keys.dart';

class LifeBar extends StatelessWidget {
  final double total;
  final double current;
  final double height = 18;
  final double spacing = 2;

  const LifeBar({
    super.key = WidgetKeys.lifeBar,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double percentage = 0;
      if (total != 0) {
        percentage = current / total;
        if (percentage > 1) percentage = 1; // Cap at 100%
      }

      // Each segment should be approximately 8-10 pixels wide including spacing
      final int dynamicSegments = (constraints.maxWidth / 10).round();

      // Calculate the number of filled segments
      final int filledSegments = (dynamicSegments * percentage).round();

      return Container(
        height: height + 4,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 0.2,
          ),
        ),
        child: Row(
          children: List.generate(dynamicSegments, (index) {
            final bool isFilled = index < filledSegments;
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: spacing / 2),
                decoration: BoxDecoration(
                  color: isFilled ? Colors.green : Colors.red.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: isFilled
                      ? [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 0,
                          )
                        ]
                      : null,
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
