import 'package:my_kakeibo/data/repository/realm/model/user_model.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:realm/realm.dart' hide Uuid, User;
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

class UserRealmRepository extends UserRepository {
  final Realm realm;
  final Uuid uuid;

  UserRealmRepository(this.realm, this.uuid);

  @override
  Future<Result<User>> getUserById(String id) async {
    try {
      final user = realm.find<UserModel>(id);

      if (user == null) {
        return Failure(Exception("User not found"));
      }

      return Success(_toEntity(user));
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> save(User user) async {
    try {
      realm.write(() => realm.add(_toModel(user)));
      return const Success("ok");
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<User>> getSelf() async {
    try {
      final users = realm.all<UserModel>();

      if (users.isEmpty) {
        return Failure(Exception("User not found"));
      }

      return Success(_toEntity(users.first));
    } catch (e) {
      return Failure(Exception(e.toString()));
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
