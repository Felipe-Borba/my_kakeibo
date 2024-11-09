import 'package:my_kakeibo/core/records/app_error.dart';
import 'package:my_kakeibo/domain/entity/notification/message.dart';
import 'package:my_kakeibo/domain/service/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotificationService implements PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<(bool, AppError)> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return (true, Empty());
    } else {
      return (false, Empty());
    }
  }

  @override
  Future<(String, AppError)> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token == null) return ("", Failure("Token not found"));

      return (token, Empty());
    } catch (e) {
      return ("", Failure(e.toString()));
    }
  }

  @override
  void listenToForegroundMessage(void Function(Message message) listener) {
    // mensagens recebidas em primeiro plano
    FirebaseMessaging.onMessage.listen(
      (event) {
        listener(Message(
          id: event.messageId,
          category: event.category,
          body: event.notification?.body,
          title: event.notification?.title,
        ));
      },
    );
  }

  @override
  void listenToBackgroundMessage(void Function(Message message) listener) {
    // Mensagens recebidas quando o aplicativo está fechado
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      listener(Message(
        id: event.messageId,
        category: event.category,
        body: event.notification?.body,
        title: event.notification?.title,
      ));
    });
  }
}
