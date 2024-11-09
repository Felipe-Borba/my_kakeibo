import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';

abstract class PushNotificationService {
  Future<(bool, AppError)> requestPermission();
  Future<(String, AppError)> getNotificationToken();

  /// Ativado quando o app está em primeiro plano
  void listenToForegroundMessage(
    void Function(NotificationMessage message) listener,
  );

  /// Ativado quando o aplicativo está fechado e o usuário clica na notificação
  void listenToBackgroundMessage(
    void Function(NotificationMessage message) listener,
  );
}
