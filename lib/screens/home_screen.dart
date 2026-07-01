import 'package:cgv_noti/screens/breaktime_screen.dart';
import 'package:cgv_noti/screens/get_noti_screen.dart';
import 'package:cgv_noti/screens/morning_screen.dart';
import 'package:cgv_noti/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

typedef ScreenItem = ({String title, IconData icon, Widget nextPage});

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ScreenItem> screenList = [
    (
      title: "morning",
      icon: Icons.wb_sunny_outlined,
      nextPage: MorningScreen(),
    ),
    (
      title: "break",
      icon: Icons.free_breakfast_outlined,
      nextPage: BreakScreen(),
    ),
    (title: "alarms", icon: Icons.alarm_on_rounded, nextPage: GetNotiScreen()),
  ];

  Future<void> _getPermission() async {
    var notificationStatus = await Permission.notification.request();
    var calendarStatus = await Permission.calendarFullAccess.request();
    if (!notificationStatus.isGranted || !calendarStatus.isGranted) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1 / 0.9,
          ),
          itemBuilder: (context, index) => CardWidget(
            title: screenList[index].title,
            icon: screenList[index].icon,
            nextPage: screenList[index].nextPage,
          ),
        ),
      ),
    );
  }
}
