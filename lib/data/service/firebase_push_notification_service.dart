import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';
import 'package:my_kakeibo/data/service/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:result_dart/result_dart.dart';

class FirebasePushNotificationService implements PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<Result<bool>> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return const Success(true);
    } else {
      return const Success(false);
    }
  }

  @override
  Future<Result<String>> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token == null) return Failure(Exception("Token not found"));

      return Success(token);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  void listenToForegroundMessage(
      void Function(NotificationMessage message) listener) {
    FirebaseMessaging.onMessage.listen(
      (event) {
        listener(NotificationMessage(
          id: event.messageId,
          category: event.category,
          body: event.notification?.body,
          title: event.notification?.title,
        ));
      },
    );
  }

  @override
  void listenToBackgroundMessage(
      void Function(NotificationMessage message) listener) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      listener(NotificationMessage(
        id: event.messageId,
        category: event.category,
        body: event.notification?.body,
        title: event.notification?.title,
      ));
    });
  }
}
