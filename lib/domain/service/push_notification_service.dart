import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/notification/message.dart';

abstract class PushNotificationService {
  Future<(bool, AppError)> requestPermission();
  Future<(String, AppError)> getNotificationToken();

  void listenToForegroundMessage(void Function(Message message) listener);

  void listenToClosedAppMessage(void Function(Message message) listener);

  void listenToBackgroundMessage(void Function(Message message) listener);
}
