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
