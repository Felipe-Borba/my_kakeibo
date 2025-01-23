import 'package:flutter/material.dart';

extension ScreenExtension on BuildContext {
  Size get screen => MediaQuery.of(this).size;
}
