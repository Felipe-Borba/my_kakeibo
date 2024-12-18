import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/data/repository/realm/model/user_model.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:realm/realm.dart' hide Uuid, User;
import 'package:uuid/uuid.dart';

class UserRealmRepository extends UserRepository {
  final Realm realm;
  final Uuid uuid;

  UserRealmRepository(this.realm, this.uuid);

  @override
  Future<(User?, AppError)> getUserById(String id) async {
    try {
      final user = realm.find<UserModel>(id);

      if (user == null) {
        return (null, Failure("User not found"));
      }

      return (_toEntity(user), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(Null, AppError)> save(User user) async {
    try {
      realm.write(() => realm.add(_toModel(user)));
      return (null, Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(User?, AppError)> getSelf() async {
    try {
      final users = realm.all<UserModel>();

      if (users.isEmpty) {
        return (null, Failure("User not found"));
      }

      return (_toEntity(users.first), Empty());
    } catch (e) {
      return (null, Failure(e.toString()));
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
      user.theme.description,
      user.balance,
      user.hasOnboarding,
      notificationToken: user.notificationToken,
    );
  }
}
