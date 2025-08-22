// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:my_kakeibo/data/notification/local_notification_service.dart';
import 'package:my_kakeibo/domain/entity/notification/local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const NotificationPocApp());
}

class NotificationPocApp extends StatelessWidget {
  const NotificationPocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification POC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const NotificationPocPage(),
    );
  }
}

class NotificationPocPage extends StatefulWidget {
  const NotificationPocPage({super.key});

  @override
  State<NotificationPocPage> createState() => _NotificationPocPageState();
}

class _NotificationPocPageState extends State<NotificationPocPage> {
  final LocalNotificationService _notificationService =
      LocalNotificationService();
  int _counter = 0;
  int _secondsLeft = 0;
  bool _isCounting = false;
  final segundos = 6;

  void _scheduleNotification() {
    setState(() {
      _counter++;
      _secondsLeft = segundos;
      _isCounting = true;
    });

    _notificationService.scheduleNotification(LocalNotification(
      date: DateTime.now().add(Duration(seconds: segundos)),
      id: _counter,
      title: 'Notificação $_counter',
      body: 'Esta é a notificação $_counter agendada para $segundos segundos!',
    ));

    _startCountdown();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() {
        _secondsLeft--;
        if (_secondsLeft <= 0) {
          _isCounting = false;
        }
      });
      return _secondsLeft > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POC Notificação Local'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isCounting
                  ? 'Notificação em $_secondsLeft segundos'
                  : 'Clique no botão para agendar uma notificação',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isCounting ? null : _scheduleNotification,
              child: Text('Agendar Notificação para ${segundos}s'),
            ),
          ],
        ),
      ),
    );
  }
}
