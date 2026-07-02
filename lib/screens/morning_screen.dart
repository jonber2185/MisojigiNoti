import 'package:cgv_noti/services/calendar_service.dart';
import 'package:cgv_noti/services/notification_service.dart';
import 'package:cgv_noti/services/toast_service.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';

class MorningScreen extends StatefulWidget {
  const MorningScreen({super.key});

  @override
  State<MorningScreen> createState() => _MorningScreenState();
}

class _MorningScreenState extends State<MorningScreen> {
  Future<void> _initState() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await NotificationService.cancelAlarms();
    await NotificationService.addAlarm(
      id: 0,
      title: "오늘 일정을 확인해봐요",
      msg: "클릭만으로 새 알람을 등록해요!",
      time: NotificationService.getTime(hour: 8),
      repeat: true,
      payload: "morning",
    );

    Event? event = await CalendarService.getTodayEvent(name: "일");

    if (event == null ||
        await NotificationService.getAlarms().then(
          (response) => response.contains(3),
        )) {
      ToastService.showToast("일정 없음");
      print("event 없음");
    } else {
      final startTime = event.start!.subtract(const Duration(minutes: 3));
      final breakTime = event.start!.add(Duration(hours: 1, minutes: 50));

      await NotificationService.addAlarm(
        id: 1,
        title: "내려갈 시간이에요!",
        msg: "출근 3분 전에 알람이 울려요",
        time: startTime,
      );
      await NotificationService.addAlarm(
        id: 2,
        title: "쉬는 시간이신가요?",
        msg: "정확한 시간을 입력해주세요!",
        time: breakTime,
        payload: "break",
      );
      ToastService.showToast("일정 등록 완료");
      print("일정 등록 완료");
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text("morning")),
    );
  }
}
