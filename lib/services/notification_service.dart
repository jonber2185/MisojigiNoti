import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:cgv_noti/main.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  NotificationService._();

  // field
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      "channelId",
      "channelName",
      priority: Priority.high,
      importance: Importance.max,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  // init
  static init() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('app_icon');
    DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    tz.initializeTimeZones();
    final TimezoneInfo timezoneInfo = await FlutterTimezone.getLocalTimezone();
    final String timezoneName = timezoneInfo.identifier;
    tz.setLocalLocation(tz.getLocation(timezoneName));

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        if (details.payload == "morning") {
          navigatorKey.currentState?.pushNamed('/morning');
        } else if (details.payload == "break") {
          navigatorKey.currentState?.pushNamed('/break');
        }
      },
    );
  }

  static Future<String> getInitialRoute() async {
    final NotificationAppLaunchDetails? details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    String? initialRoute = '/';
    if (details?.didNotificationLaunchApp ?? false) {
      if (details?.notificationResponse?.payload == 'morning') {
        initialRoute = '/morning';
      } else if (details?.notificationResponse?.payload == 'break') {
        initialRoute = '/break';
      }
    }
    return initialRoute;
  }

  // method
  static Future<List<int>> getAlarms() async {
    List<int> result = [];
    final pendings = await flutterLocalNotificationsPlugin
        .pendingNotificationRequests();

    for (var pending in pendings) {
      result.add(pending.id);
    }

    return result;
  }

  static Future<void> addAlarm({
    required int id,
    required String title,
    required String msg,
    required DateTime time,
    bool repeat = false,
    String? payload,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      time.day,
      time.hour,
      time.minute,
      0,
      0,
    );
    if (scheduledDate.isBefore(now)) return;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      msg,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: repeat ? DateTimeComponents.time : null,
      payload: payload,
    );
    print("?Œë¦¼ ?¤ì • : $scheduledDate");
  }

  static DateTime getTime({int hour = 0, int minute = 0}) {
    final now = DateTime.now();
    var time = DateTime(now.year, now.month, now.day, hour, minute);
    if (time.isBefore(now)) {
      time = time.add(const Duration(days: 1));
    }
    return time;
  }

  static Future<void> cancelAlarms([List<int> ids = const []]) async {
    if (ids.isEmpty) {
      await flutterLocalNotificationsPlugin.cancelAll();
      print("?Œë¦¼ ?„ë? ?? œ");
    } else {
      Future.forEach(ids, (id) async {
        await flutterLocalNotificationsPlugin.cancel(id);
      });
      print("?Œë¦¼ ?? œ : $ids");
    }
  }
}
