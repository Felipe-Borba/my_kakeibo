import 'package:flutter/material.dart';

extension ScreenExtension on BuildContext {
  Size get screen => MediaQuery.of(this).size;

  /// Convert the given percentage to a double value.
  double percentage(double percent) {
    return screen.width * percent / 100;
  }
}
