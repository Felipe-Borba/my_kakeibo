import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_kakeibo/domain/entity/notification/local_notification.dart';
import 'package:my_kakeibo/domain/entity/custom_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNotificationService() {
    _initialize();
  }

  void _initialize() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotificationsPlugin.initialize(initializationSettings);

    await _localNotificationsPlugin
        .getActiveNotifications()
        .then((notifications) {
      if (notifications.isNotEmpty) {
        // Handle active notifications if needed
        if (kDebugMode) {
          print('Active notifications: $notifications');
        }
      }
    });
    await _localNotificationsPlugin
        .pendingNotificationRequests()
        .then((requests) {
      if (requests.isNotEmpty) {
        // Handle pending notification requests if needed
        if (kDebugMode) {
          print('Pending notification requests: $requests');
        }
      }
    });
  }

  // Future<Result<void>> displayNotification(NotificationMessage message) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     "pushNotificationId",
  //     "pushNotification",
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );

  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.title,
  //     message.body,
  //     notificationDetails,
  //   );
  //   return const Success("ok");
  // }

  AsyncResult<Unit> scheduleNotification(LocalNotification notification) async {
    try {
      final granted = await _checkNotificationPermissions();
      if (!granted) {
        return Failure(CustomException.notificationPermissionNotGranted());
      }

      if(!notification.inFuture()) {
        return Failure(CustomException.notificationDateInPast());
      }

      final scheduledDate = tz.TZDateTime.from(
        notification.date,
        tz.local,
      );

      await _localNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        scheduledDate,
        _getNotificationDetails(notification.channel),
        // payload: notification.payload,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        // matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<bool> _checkNotificationPermissions() async {
    final androidPlugin =
        _localNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      return await androidPlugin.requestNotificationsPermission() ?? false;
    }

    final iosPlugin =
        _localNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (iosPlugin != null) {
      return await iosPlugin.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    return false;
  }

  NotificationDetails _getNotificationDetails(NotificationChannel channel) {
    return switch (channel) {
      NotificationChannel.standard => const NotificationDetails(
          android: AndroidNotificationDetails(
            "standard",
            "Standard Notifications",
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: false,
          ),
        ),
    };
  }
}
