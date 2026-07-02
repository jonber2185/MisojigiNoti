import 'package:device_calendar/device_calendar.dart';

class CalendarService {
  static final DeviceCalendarPlugin deviceCalendarPlugin =
      DeviceCalendarPlugin();

  static Future<Event?> getTodayEvent({required String name}) async {
    final calendarResult = await deviceCalendarPlugin.retrieveCalendars();

    if (calendarResult.isSuccess && calendarResult.data != null) {
      final calendars = calendarResult.data ?? [];

      String? calendarId;
      for (var calendar in calendars) {
        if (calendar.name == name) {
          calendarId = calendar.id;
          break;
        }
      }

      final now = DateTime.now();
      final startDate = DateTime(now.year, now.month, now.day);
      final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
      final eventsResult = await deviceCalendarPlugin.retrieveEvents(
        calendarId,
        RetrieveEventsParams(startDate: startDate, endDate: endDate),
      );

      if (eventsResult.isSuccess && eventsResult.data != null) {
        final List<Event> events = eventsResult.data!.toList();
        return events.firstOrNull;
      }
    } else {
      print("calendar 조회 실패");
    }
    return null;
  }
}
