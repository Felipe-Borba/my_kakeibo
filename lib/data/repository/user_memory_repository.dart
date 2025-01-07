import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class UserMemoryRepository implements UserRepository {
  User? _user;

  @override
  Future<Result<void>> save(User user) async {
    _user = user;
    return const Success("ok");
  }

  @override
  Future<Result<User>> getUserById(String id) async {
    if (_user != null) {
      return Success(_user!);
    } else {
      return Failure(Exception("User not found"));
    }
  }

  @override
  Future<Result<User>> getSelf() async {
    if (_user != null) {
      return Success(_user!);
    } else {
      return Failure(Exception("User not found"));
    }
  }
}
