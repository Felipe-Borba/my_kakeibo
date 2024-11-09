import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/auth_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/push_notification_service.dart';

class UserUseCase {
  UserRepository userRepository;
  AuthRepository authRepository;
  PushNotificationService pushNotificationService;

  UserUseCase({
    required this.userRepository,
    required this.authRepository,
    required this.pushNotificationService,
  });

  Future<(Null, AppError)> insert(User user) async {
    var (id, err) = await authRepository.createAccess(
      user.email,
      user.password,
    );
    if (err is! Empty) {
      return (null, err);
    }

    user.id = id;
    await userRepository.save(user);

    return (null, Empty());
  }

  Future<(User?, AppError)> getUser() async {
    var (id, err) = await authRepository.getLoggedUserId();
    if (err is! Empty) {
      return (null, err);
    }
    return await userRepository.getUserById(id);
  }

  Future<(Null, AppError)> update(User user) async {
    return await userRepository.save(user);
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

    await _checkPushNotificationSettings(user!);

    return (user, Empty());
  }

  Future<(Null, AppError)> logOut() async {
    return authRepository.logOut();
  }

  //testar como isso ficaria usado monad para tratamento de erro
  Future<(Null, AppError)> _checkPushNotificationSettings(User user) async {
    var (permission, err1) = await pushNotificationService.requestPermission();
    if (err1 is Failure) return (null, err1);

    var (token, err2) = await pushNotificationService.getNotificationToken();

    if (err2 is Failure) return (null, err2);
    user.notificationToken = token;

    var (saved, err3) = await userRepository.save(user);
    if (err3 is Failure) return (null, err2);

    return (null, Empty());
  }
}
