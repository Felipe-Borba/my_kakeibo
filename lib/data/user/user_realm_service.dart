import 'package:my_kakeibo/data/realm/model/models.dart';
import 'package:my_kakeibo/data/realm/realm_config.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/exceptions/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

class UserRealmService {
  final realm = RealmConfig().realm;
  final uuid = RealmConfig().uuid;

  AsyncResult<User> insert(User user) async {
    try {
      final model = _toModel(user);
      realm.write(() {
        realm.add(model);
      });
      return Success(_toEntity(model));
    } catch (e) {
      return Failure(CustomException.unknownError());
    }
  }

  AsyncResult<User> update(User user) async {
    try {
      final users = realm.all<UserModel>();
      if (users.isEmpty) {
        return Failure(CustomException.userNotFound());
      }
      final model = users.first;

      realm.write(() {
        model.name = user.name;
        model.email = user.email;
        model.password = user.password;
        model.balance = user.balance;
        model.notificationToken = user.notificationToken;
        model.theme = user.theme;
        model.hasOnboarding = user.hasOnboarding;
        model.authId = user.authId;
      });
      return Success(_toEntity(model));
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
      user.theme.index,
      notificationToken: user.notificationToken,
    );
  }
}
