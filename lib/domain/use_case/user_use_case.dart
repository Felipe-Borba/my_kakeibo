import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/auth_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserUseCase {
  UserRepository userRepository;
  AuthRepository authRepository;

  UserUseCase({
    required this.userRepository,
    required this.authRepository,
  });

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

  Future<(User?, AppError)> login(String email, String password) async {
    var (id, loginErr) = await authRepository.login(email, password);
    if (loginErr is! Empty) {
      return (null, loginErr);
    }

    var (user, userErr) = await userRepository.getUserById(id);
    if (userErr is! Empty) {
      return (null, userErr);
    }

    return (user, Empty());
  }
}
