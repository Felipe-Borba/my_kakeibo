import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/domain/repository/user_repository.dart';
import 'package:my_kakeibo/domain/service/local_notification_service.dart';
import 'package:my_kakeibo/domain/service/push_notification_service.dart';

class NotificationUseCase {
  final UserRepository _userRepository;
  final PushNotificationService _pushNotificationService;
  final LocalNotificationService _localNotificationService;

  NotificationUseCase(
    this._userRepository,
    this._pushNotificationService,
    this._localNotificationService,
  ) {
    _pushNotificationService.listenToBackgroundMessage(
      (message) {
        // fazer alguma coisa quando o usuário clica no notificação
      },
    );
    _pushNotificationService.listenToForegroundMessage(
      (message) {
        // Como eu faço para mostrar a notificação na tela do jeitinho que aparece lá no preview do firebase, existe alguma outra lib para isso fora a local notification
        // Ou tenho que usar a local notification mesmo?
        _localNotificationService.displayNotification(message);
      },
    );
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

    return (null, Empty());
  }
}
