import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';

abstract class UserRepository {
  Future<(Null, AppError)> save(User user);

  //Tenho algumas dúvidas se eu não vou acabar espalhando um monte de null check chato por causa dessa decisão XD
  Future<(User?, AppError)> getUser();

  Future<(User?, AppError)> getUserById(String id);
}
