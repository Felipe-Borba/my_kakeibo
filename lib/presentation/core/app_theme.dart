import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/font.dart';
import 'package:my_kakeibo/presentation/core/theme.dart';

MaterialTheme getMaterialTheme(BuildContext context) {
  TextTheme textTheme = createTextTheme(context, "Inter", "Inter");
  return MaterialTheme(textTheme);
}
