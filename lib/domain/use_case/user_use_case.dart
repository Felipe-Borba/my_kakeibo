import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/auth_repository.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/push_notification_service.dart';

class UserUseCase {
  late final UserRepository _userRepository;
  late final AuthRepository _authRepository;
  late final PushNotificationService _pushNotificationService;

  UserUseCase({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required PushNotificationService pushNotificationService,
  })  : _pushNotificationService = pushNotificationService,
        _authRepository = authRepository,
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

  //testar como isso ficaria usado monad para tratamento de erro
  Future<(Null, AppError)> checkPushNotificationSettings(User user) async {
    var (permission, err1) = await _pushNotificationService.requestPermission();
    if (err1 is Failure) return (null, err1);
    if (permission == false) return (null, Empty());

    var (token, err2) = await _pushNotificationService.getNotificationToken();

    if (err2 is Failure) return (null, err2);
    user.notificationToken = token;

    var (saved, err3) = await _userRepository.save(user);
    if (err3 is Failure) return (null, err2);

    _pushNotificationService.listenToForegroundMessage(
      (message) {
        print(message);
      },
    );
    _pushNotificationService.listenToBackgroundMessage(
      (message) {
        print(message);
      },
    );

    return (null, Empty());
  }
}
