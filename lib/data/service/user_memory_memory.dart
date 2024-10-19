import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserMemoryDatabase implements UserRepository {
  User? _user;

  @override
  Future<(User?, AppError)> getUser() async {
    if (_user != null) {
      return (_user, Empty());
    } else {
      return (null, Failure("User not found"));
    }
  }

  @override
  Future<(Null, AppError)> save(User user) async {
    _user = user;
    return (null, Empty());
  }
  
  @override
  Future<(User, AppError)> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }
}
