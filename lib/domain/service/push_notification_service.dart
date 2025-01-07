import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';
import 'package:result_dart/result_dart.dart';

abstract class PushNotificationService {
  Future<Result<bool>> requestPermission();

  Future<Result<String>> getNotificationToken();

  /// Ativado quando o app está em primeiro plano
  void listenToForegroundMessage(
    void Function(NotificationMessage message) listener,
  );

  /// Ativado quando o aplicativo está fechado e o usuário clica na notificação
  void listenToBackgroundMessage(
    void Function(NotificationMessage message) listener,
  );
}
