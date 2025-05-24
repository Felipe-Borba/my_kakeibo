import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';

extension ColorCustomMapper on ColorCustom {
  Color toColor() {
    return switch (this) {
      ColorCustom.brown => Colors.brown,
      ColorCustom.blue => Colors.blue,
      ColorCustom.purple => Colors.purple,
      ColorCustom.orange => Colors.orange,
      ColorCustom.yellow => Colors.yellow,
      ColorCustom.green => Colors.green,
      ColorCustom.grey => Colors.grey
    };
  }
}
