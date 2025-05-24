import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationsExtension on BuildContext {
  AppLocalizations get intl => AppLocalizations.of(this)!;
  Locale get locale => Localizations.localeOf(this);
}
