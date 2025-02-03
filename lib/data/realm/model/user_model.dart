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
  late int _themeValue;
  UserTheme get theme => UserTheme.values[_themeValue];
  set theme(UserTheme theme) => _themeValue = theme.index;
}
