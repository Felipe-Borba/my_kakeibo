import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/auth_service.dart';
import 'package:result_dart/result_dart.dart';

class UserUseCase {
  late final UserRepository _userRepository;
  late final AuthService _authRepository;

  UserUseCase({
    required UserRepository userRepository,
    required AuthService authRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  Future<Result<void>> insert(User user) async {
    var id = await _authRepository
        .createAccess(
          user.email,
          user.password,
        )
        .getOrThrow();

    user.id = id;
    return await _userRepository.save(user);
  }

  //TODO na nova arquitetura recomendada pelo flutter eles recomendam evitar isso e por isso permitem o uso direto do repository nos outros lugares inclusive viewModel
  Future<Result<void>> save(User user) async {
    return await _userRepository.save(user);
  }

  Future<Result<User>> getUser() async {
    return await _userRepository.getSelf();
  }

  Future<Result<void>> update(User user) async {
    return await _userRepository.save(user);
  }

  Future<Result<User>> login(String email, String password) async {
    await _authRepository.login(email, password).getOrThrow();

    return await _userRepository.getSelf();
  }

  Future<Result<void>> logOut() async {
    return _authRepository.logOut();
  }

  Future<Result<void>> deleteData() async {
    throw UnimplementedError('TODO interfaces e implementar');
  }
}
