import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/components/text/text_label_medium.dart';
import 'package:my_kakeibo/presentation/core/extensions/currency.dart';
import 'package:my_kakeibo/presentation/core/extensions/screen_extension.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.value,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final double value;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              constraints:
                  BoxConstraints(maxWidth: context.screenPercentage(30)),
              child: Tooltip(
                message: text,
                preferBelow: false,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          constraints: BoxConstraints(maxWidth: context.screenPercentage(30)),
          child: Tooltip(
            message: context.currency.format(value),
            preferBelow: false,
            child: TextLabelMedium(
              context.currency.format(value),
              customTheme: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ],
    );
  }
}
