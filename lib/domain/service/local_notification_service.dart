import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';

abstract class LocalNotificationService {
  /// Serve somente para mostrar um popup na tela mostrando a notificação quando o app está aberto
  Future<void> displayNotification(NotificationMessage message);
}
