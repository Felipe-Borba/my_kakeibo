import 'package:my_kakeibo/domain/entity/user/user.dart';
import 'package:my_kakeibo/data/repository/user_repository.dart';
import 'package:my_kakeibo/data/service/local_notification_service.dart';
import 'package:my_kakeibo/data/service/push_notification_service.dart';
import 'package:result_dart/result_dart.dart';

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

  Future<Result<void>> checkPushNotificationSettings(User user) async {
    var permission = await _pushNotificationService
        .requestPermission() //
        .getOrDefault(false);

    //TODO ver uma forma melhor, ex. centralizar os erros ai qdo precisar usar o operador is
    if (permission == false) return Failure(Exception("Permission denied"));

    var token = await _pushNotificationService
        .getNotificationToken() //
        .getOrNull();

    user.notificationToken = token;

    return await _userRepository.save(user);
  }
}
