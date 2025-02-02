part of 'models.dart';

@RealmModel()
class _UserModel {
  @PrimaryKey()
  late String id;

  late String name;

  late String email;

  late String password;

  late double balance;

  late String? notificationToken;

  late bool hasOnboarding;

  late String? authId;

  @MapTo('theme')
  late String _themeString;
  UserTheme get theme => UserTheme.values.getByDescription(_themeString);
  set theme(UserTheme theme) => _themeString = theme.description;
}
