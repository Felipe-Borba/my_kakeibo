import 'package:flutter/material.dart';
import 'package:my_kakeibo/domain/entity/transaction/color_custom.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

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

    String getTranslation(BuildContext context) {
    return switch (this) {
      ColorCustom.brown => context.intl.brown,
      ColorCustom.blue => context.intl.blue,
      ColorCustom.purple => context.intl.purple,
      ColorCustom.orange => context.intl.orange,
      ColorCustom.yellow => context.intl.yellow,
      ColorCustom.green => context.intl.green,
      ColorCustom.grey => context.intl.grey,
    };
  }
}
