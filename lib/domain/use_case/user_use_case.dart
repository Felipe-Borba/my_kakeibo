import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserUseCase {
  UserRepository userRepository;

  UserUseCase({required this.userRepository});
  // TODO como vou validar esse treco
  // TODO Me acoplo aqui ao ValueNotifier como no fluterando?
  /// quero permitir usar qualquer tipo de gerenciamento de estado lá na presentation?
  /// se eu acoplar lá no teste eu consigo testar mais isoladamente os métodos...

  Future<(Null, AppError)> insert(User user) async {
    await userRepository.save(user);
    return (null, Empty());
  }

  Future<(User?, AppError)> getUser() async {
    return await userRepository.getUser();
  }
}
