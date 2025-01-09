import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';
import 'package:result_dart/result_dart.dart';

abstract class LocalNotificationService {
  /// Serve somente para mostrar um popup na tela mostrando a notificação quando o app está aberto
  Future<Result<void>> displayNotification(NotificationMessage message);

  Future<Result<void>> scheduleNotification(Notification notification);
}

//TODO pq isso não tá na entity mesmo?
class Notification {
  int id;
  DateTime date;
  String? title;
  String? body;
  NotificationChannel channel;

  Notification({
    required this.date,
    required this.id,
    this.title,
    this.body,
    this.channel = NotificationChannel.standard,
  });
}

enum NotificationChannel {
  standard,
}
