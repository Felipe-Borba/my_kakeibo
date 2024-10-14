import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserMemoryRepository implements UserRepository {
  User? _user;

  @override
  Future<User?> getUser() async {
    return _user;
  }

  @override
  Future<void> save(User user) async {
    _user = user;
  }
}
