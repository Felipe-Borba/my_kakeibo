enum UserTheme {
  system,
  light,
  dark,
}

extension UserThemeExtension on UserTheme {
  String get description => toString().split('.').last;
}

extension UserThemeListExtension on List<UserTheme> {
  UserTheme getByDescription(String description) {
    return firstWhere((e) => e.description == description);
  }
}
