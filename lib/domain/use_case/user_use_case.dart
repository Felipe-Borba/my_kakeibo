import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserUseCase {
  UserRepository userRepository;

  UserUseCase({required this.userRepository});

  Future<void> insert(User user) async {
    await userRepository.save(user);
  }

  Future<User?> getUser() async {
    return await userRepository.getUser();
  }
}
