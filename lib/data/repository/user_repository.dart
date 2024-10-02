import 'package:my_kakeibo/data/entity/user.dart';

abstract class UserRepository {
  void save(User user);

  Future<User?> getUser();
}
