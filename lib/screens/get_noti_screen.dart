import 'package:cgv_noti/services/notification_service.dart';
import 'package:cgv_noti/widgets/alarm_card_widget.dart';
import 'package:flutter/material.dart';

class GetNotiScreen extends StatefulWidget {
  const GetNotiScreen({super.key});

  @override
  State<GetNotiScreen> createState() => _GetNotiScreenState();
}

class _GetNotiScreenState extends State<GetNotiScreen> {
  final List<String> title = ["아침 알람", "출근 알람", "휴게 전 알람", "휴게 알람"];
  List<bool> alarms = List.filled(4, false);

  Future<void> _initState() async {
    final response = await NotificationService.getAlarms();
    for (var e in response) {
      alarms[e] = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("alarms")),
      body: GridView.builder(
        itemCount: 4,
        padding: EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 2 / 1,
        ),
        itemBuilder: (context, index) =>
            AlarmCardWidget(status: alarms[index], title: title[index]),
      ),
    );
  }
}
