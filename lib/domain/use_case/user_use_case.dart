import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class necessidade {
  UserRepository userRepository;

  necessidade({required this.userRepository});
  // TODO Aqui eu já vou ter que tomar umas decisões de tratamento de erro tipo o Result, ou a tupla
  // TODO como vou validar esse treco
  // TODO 

  Future<void> insert(User user) async {
    await userRepository.save(user);
  }

  Future<User?> getUser() async {
    return await userRepository.getUser();
  }
}
