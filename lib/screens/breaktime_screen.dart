import 'package:cgv_noti/services/notification_service.dart';
import 'package:cgv_noti/services/toast_service.dart';
import 'package:cgv_noti/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreakScreen extends StatefulWidget {
  const BreakScreen({super.key});

  @override
  State<BreakScreen> createState() => _BreakScreenState();
}

class _BreakScreenState extends State<BreakScreen> {
  DateTime pickedDate = DateTime.now().subtract(Duration(minutes: 2));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _popUp();
    });
  }

  Future<void> _onPressed() async {
    await NotificationService.addAlarm(
      id: 3,
      title: "복귀할 시간이에요",
      msg: "휴식 종료 3분 전에 알람이 울려요",
      time: pickedDate.add(Duration(minutes: 27)),
    );
    await NotificationService.cancelAlarms([1, 2]);
    ToastService.showToast("휴게시간 설정 완료");
  }

  Future<void> _popUp() async {
    if (!mounted) return;
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Text("취소", style: TextStyle(color: Colors.red)),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: Text("완료"),
                  onPressed: () {
                    _onPressed();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: pickedDate,
                onDateTimeChanged: (DateTime newTime) => pickedDate = newTime,
              ),
            ),
            SizedBox(
              height: 50,
              child: Material(
                color: Colors.transparent,
                child: Text("", style: Style.defaultTextStyle),
              ),
            ),
          ],
        ),
      ),
    );
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
