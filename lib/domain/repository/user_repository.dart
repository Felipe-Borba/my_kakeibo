import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';

abstract class UserRepository {
  Future<(Null, AppError)> save(User user);

  @Deprecated("use getSelf instead")
  Future<(User?, AppError)> getUserById(String id);

  Future<(User?, AppError)> getSelf();

  // Future<(Null, AppError)> deleteById(String id);
}
