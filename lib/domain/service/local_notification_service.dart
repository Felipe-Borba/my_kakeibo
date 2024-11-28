// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';

abstract class LocalNotificationService {
  /// Serve somente para mostrar um popup na tela mostrando a notificação quando o app está aberto
  Future<void> displayNotification(NotificationMessage message);

  Future<(Null, AppError)> scheduleNotification(Notification notification);
}

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
