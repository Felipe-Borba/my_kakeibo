import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user.dart';

abstract class UserRepository {
  Future<(Null, AppError)> save(User user);

  Future<(User?, AppError)> getUser();
}
