import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserUseCase {
  UserRepository userRepository;

  UserUseCase({required this.userRepository});

  Future<(Null, AppError)> insert(User user) async {
    var (isValid, errorList) = user.validate();
    if (!isValid) {
      return (null, errorList);
    }

    await userRepository.save(user);

    return (null, Empty());
  }

  Future<(User?, AppError)> getUser() async {
    return await userRepository.getUser();
  }

  Future<(User, AppError)> login(String email, String password) async {
    throw Exception("Todo");
  }
}
