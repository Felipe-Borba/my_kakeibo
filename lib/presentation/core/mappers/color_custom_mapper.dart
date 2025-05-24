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
      ColorCustom.grey => Colors.grey,
      ColorCustom.pink => Colors.pink,
      ColorCustom.cyan => Colors.cyan,
      ColorCustom.lime => Colors.lime,
      ColorCustom.indigo => Colors.indigo,
      ColorCustom.teal => Colors.teal,
      ColorCustom.amber => Colors.amber,
      ColorCustom.blueGrey => Colors.blueGrey,
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
      ColorCustom.pink => context.intl.pink,
      ColorCustom.cyan => context.intl.cyan,
      ColorCustom.lime => context.intl.lime,
      ColorCustom.indigo => context.intl.indigo,
      ColorCustom.teal => context.intl.teal,
      ColorCustom.amber => context.intl.amber,
      ColorCustom.blueGrey => context.intl.blueGrey,
    };
  }
}
