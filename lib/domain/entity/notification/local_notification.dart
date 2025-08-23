class LocalNotification {
  int id;
  DateTime date;
  String? title;
  String? body;
  NotificationChannel channel;

  LocalNotification({
    required this.date,
    id,
    this.title,
    this.body,
    this.channel = NotificationChannel.standard,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF;
}

enum NotificationChannel {
  standard,
}
