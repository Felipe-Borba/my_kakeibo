import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class UserRepository {
  Future<Result<void>> save(User user);

  @Deprecated("use getSelf instead")
  Future<Result<User>> getUserById(String id);

  Future<Result<User>> getSelf();
}
