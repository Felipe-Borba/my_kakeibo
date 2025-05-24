import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:my_kakeibo/domain/entity/user/user_language.dart';
import 'package:my_kakeibo/presentation/core/extensions/intl.dart';

extension UserLanguageMapper on UserLanguage {
  Locale toLocale() {
    return switch (this) {
      UserLanguage.english => const Locale("en"),
      UserLanguage.portuguese => const Locale("pt"),
    };
  }

  String getTranslation(BuildContext context) {
    return switch (this) {
      UserLanguage.english => context.intl.english,
      UserLanguage.portuguese => context.intl.portuguese,
    };
  }

  static List<Locale> getSupportedLanguages() {
    return UserLanguage.values.map((language) => language.toLocale()).toList();
  }

  static UserLanguage getSystemLanguage() {
    final Locale deviceLocale = PlatformDispatcher.instance.locale;
    return UserLanguage.values.firstWhere(
      (language) =>
          language.toLocale().languageCode == deviceLocale.languageCode,
      orElse: () => UserLanguage.english,
    );
  }
}
