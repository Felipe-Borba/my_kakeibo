import 'package:flutter/material.dart';
import 'package:my_kakeibo/core/extensions/intl.dart';

class User {
  String? id;
  String name;
  String email;
  String password;
  UserTheme theme;
  double balance;
  String? notificationToken;
  bool hasOnboarding;
  String? authId;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.notificationToken,
    this.theme = UserTheme.light,
    this.balance = 0.0,
    this.hasOnboarding = false,
    this.authId,
  });

  factory User.createOnboardingUser(String name) {
    return User(name: name, email: "", password: "");
  }

  decreaseBalance(double amount) {
    balance -= amount;
  }

  increaseBalance(double amount) {
    balance += amount;
  }
}

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
