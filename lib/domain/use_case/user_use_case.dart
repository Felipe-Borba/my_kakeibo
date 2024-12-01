import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/service/auth_service.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';

class UserUseCase {
  late final UserRepository _userRepository;
  late final AuthService _authRepository;

  UserUseCase({
    required UserRepository userRepository,
    required AuthService authRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  Future<(Null, AppError)> insert(User user) async {
    var (id, err) = await _authRepository.createAccess(
      user.email,
      user.password,
    );
    if (err is! Empty) {
      return (null, err);
    }

    user.id = id;
    await _userRepository.save(user);

    return (null, Empty());
  }

  Future<(User?, AppError)> getUser() async {
    var (id, err) = await _authRepository.getLoggedUserId();
    //verificar se já tem alguma coisa local
    if (err is! Empty) {
      return (null, err);
    }
    return await _userRepository.getUserById(id);
  }

  Future<(Null, AppError)> update(User user) async {
    return await _userRepository.save(user);
  }

  Future<(User?, AppError)> login(String email, String password) async {
    var (id, loginErr) = await _authRepository.login(email, password);
    if (loginErr is! Empty) {
      return (null, loginErr);
    }

    var (user, userErr) = await _userRepository.getUserById(id);
    if (userErr is! Empty) {
      return (null, userErr);
    }

    return (user, Empty());
  }

  Future<(Null, AppError)> logOut() async {
    return _authRepository.logOut();
  }
}
