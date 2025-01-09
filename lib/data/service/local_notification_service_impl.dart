import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_kakeibo/domain/entity/notification/notification_message.dart';
import 'package:my_kakeibo/data/service/local_notification_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServiceImpl implements LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNotificationServiceImpl() {
    _initialize();
  }

  void _initialize() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettingsLinux = LinuxInitializationSettings(
      defaultActionName: "Open notification",
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<Result<void>> displayNotification(NotificationMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "pushNotificationId",
      "pushNotification",
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.title,
      message.body,
      notificationDetails,
    );
    return const Success("ok");
  }

  @override
  Future<Result<void>> scheduleNotification(
    Notification notification,
  ) async {
    try {
      final androidDetails = AndroidNotificationDetails(
        notification.channel.name,
        notification.channel.name,
        importance: Importance.high,
        priority: Priority.high,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
      );

      final scheduledDate = tz.TZDateTime.from(
        notification.date,
        tz.local,
      );

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexact,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      return const Success("ok");
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
