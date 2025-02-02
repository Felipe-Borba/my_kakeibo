import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:my_kakeibo/data/realm/realm_config.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/entity/user/user_theme.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class UserRealmService {
  final realm = RealmConfig().realm;
  final uuid = RealmConfig().uuid;

  Future<Result<void>> save(User user) async {
    try {
      realm.write(() => realm.add(_toModel(user)));
      return const Success("ok");
    } catch (e) {
      return Failure(CustomException.unknownError());
    }
  }

  Future<Result<User>> getSelf() async {
    try {
      final users = realm.all<UserModel>();

      if (users.isEmpty) {
        return Failure(CustomException.userNotFound());
      }

      return Success(_toEntity(users.first));
    } catch (e) {
      return Failure(CustomException.unknownError());
    }
  }

  User _toEntity(UserModel model) {
    return User(
      name: model.name,
      email: model.email,
      password: model.password,
      balance: model.balance,
      id: model.id,
      notificationToken: model.notificationToken,
      theme: model.theme,
      hasOnboarding: model.hasOnboarding,
    );
  }

  UserModel _toModel(User user) {
    return UserModel(
      user.id ?? uuid.v4(),
      user.name,
      user.email,
      user.password,
      user.balance,
      user.hasOnboarding,
      user.theme.description,
      notificationToken: user.notificationToken,
    );
  }
}
