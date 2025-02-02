import 'package:my_kakeibo/data/user/user_realm_service.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:result_dart/result_dart.dart';

class UserRepository {
  late final UserRealmService _userService;
  //TODO fazer stream

  UserRepository(this._userService);

  Future<Result<void>> insert(User user) async {
    return await _userService.save(user);
  }

  Future<Result<void>> save(User user) async {
    return await _userService.save(user);
  }

  Future<Result<User>> getUser() async {
    return await _userService.getSelf();
  }

  Future<Result<void>> update(User user) async {
    return await _userService.save(user);
  }

  Future<Result<User>> login(String email, String password) async {
    return await _userService.getSelf();
  }

  Future<Result<void>> deleteData() async {
    throw UnimplementedError('TODO interfaces e implementar');
  }
}
