import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:realm/realm.dart';

part 'user_model.realm.dart';

@RealmModel()
class _UserModel {
  @PrimaryKey()
  late String id;
  late String name;
  late String email;
  late String password;
  late String themeString;
  late double balance;
  late String? notificationToken;
  late bool hasOnboarding;
  late String? authId;

  UserTheme get theme => UserTheme.values.getByDescription(themeString);

  set theme(UserTheme theme) {
    themeString = theme.toString().split('.').last;
  }
}
