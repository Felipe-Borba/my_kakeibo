import 'package:flutter/material.dart';

extension ScreenExtension on BuildContext {
  Size get screen => MediaQuery.of(this).size;

  /// Convert the given percentage to a double value.
  /// Should use value between 0 and 100.
  double screenPercentage(double percent) {
    return screen.width * percent / 100;
  }
}
