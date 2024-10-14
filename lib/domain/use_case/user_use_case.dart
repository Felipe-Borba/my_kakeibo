import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserUseCase {
  UserRepository userRepository;

  UserUseCase({required this.userRepository});

  Future<void> insert(User user) async {
    throw Exception("To be implemented");
  }

  Future<User> getUser() async {
    throw Exception("To be implemented");
  }
}
