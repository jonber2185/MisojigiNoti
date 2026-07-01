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
      title: "?¤ëŠ˜ ?¼ì •???•ì¸?´ë´??",
      msg: "?´ë¦­ë§Œìœ¼ë¡??ŒëŒ???±ë¡?¼ìš”!",
      time: NotificationService.getTime(hour: 8),
      repeat: true,
      payload: "morning",
    );

    Event? event = await CalendarService.getTodayEvent(name: "??);

    if (event == null ||
        await NotificationService.getAlarms().then(
          (response) => response.contains(3),
        )) {
      ToastService.showToast("?¼ì • ?†ìŒ");
      print("event ?†ìŒ");
    } else {
      final startTime = event.start!.subtract(const Duration(minutes: 3));
      final breakTime = event.start!.add(Duration(hours: 1, minutes: 50));

      await NotificationService.addAlarm(
        id: 1,
        title: "?˜ê°ˆ ?œê°„?´ì—??",
        msg: "ì¶œê·¼ 3ë¶??„ì— ?ŒëŒ???¸ë ¤??",
        time: startTime,
      );
      await NotificationService.addAlarm(
        id: 2,
        title: "?´ê°œ?œê°„?´ì‹ ê°€??",
        msg: "?•í™•???œê°„???…ë ¥?´ì£¼?¸ìš”!",
        time: breakTime,
        payload: "break",
      );
      ToastService.showToast("?¼ì • ?±ë¡ ?„ë£Œ");
      print("?¼ì • ?±ë¡ ?„ë£Œ");
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
