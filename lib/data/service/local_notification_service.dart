import 'package:my_kakeibo/domain/entity/notification/notification.dart';
import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';
import 'package:result_dart/result_dart.dart';

abstract class LocalNotificationService {
  /// Serve somente para mostrar um popup na tela mostrando a notificação quando o app está aberto
  Future<Result<void>> displayNotification(NotificationMessage message);

  Future<Result<void>> scheduleNotification(Notification notification);
}

