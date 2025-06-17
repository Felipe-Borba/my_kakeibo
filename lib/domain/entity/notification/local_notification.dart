class LocalNotification {
  int id;
  DateTime date;
  String? title;
  String? body;
  NotificationChannel channel;

  LocalNotification({
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
