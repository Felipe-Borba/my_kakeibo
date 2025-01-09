import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

enum UserTheme {
  system,
  light,
  dark,
}

extension UserThemeExtension on UserTheme {
  String getTranslation(BuildContext context) {
    switch (this) {
      case UserTheme.system:
        return context.intl.systemTheme;
      case UserTheme.light:
        return context.intl.lightTheme;
      case UserTheme.dark:
        return context.intl.darkTheme;
    }
  }

  ThemeMode toThemeMode() {
    switch (this) {
      case UserTheme.system:
        return ThemeMode.system;
      case UserTheme.light:
        return ThemeMode.light;
      case UserTheme.dark:
        return ThemeMode.dark;
    }
  }

  String get description => toString().split('.').last;
}

extension UserThemeListExtension on List<UserTheme> {
  UserTheme getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
