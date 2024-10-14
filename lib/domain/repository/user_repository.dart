import 'package:my_kakeibo/domain/entity/user.dart';

abstract class UserRepository {
  Future<void> save(User user);

  Future<User?> getUser();
}
