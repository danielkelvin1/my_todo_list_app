import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/v1.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static NotificationService? _instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications.",
    importance: Importance.high,
  );

  NotificationService._();

  static NotificationService get instance {
    _instance ??= NotificationService._();
    return _instance!;
  }

  Future setup() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void setNotification(DateTime date, String id, String title, String body) {
    tz.initializeTimeZones();
    flutterLocalNotificationsPlugin.zonedSchedule(
      const UuidV1().hashCode,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(
        date.difference(
          DateTime.now(),
        ),
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: "launch_background",
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void updateNotification(DateTime date, int id, String title, String body) {
    tz.initializeTimeZones();
    flutterLocalNotificationsPlugin.cancel(id);
    flutterLocalNotificationsPlugin.zonedSchedule(
      const UuidV1().hashCode,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(
        date.difference(
          DateTime.now(),
        ),
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: "launch_background",
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
