import 'package:cgv_noti/screens/breaktime_screen.dart';
import 'package:cgv_noti/screens/home_screen.dart';
import 'package:cgv_noti/screens/morning_screen.dart';
import 'package:cgv_noti/services/notification_service.dart';
import 'package:cgv_noti/style.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  String? initialRoute = await NotificationService.getInitialRoute();

  runApp(App(initialRoute: initialRoute));
}

class App extends StatelessWidget {
  final String? initialRoute;

  const App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CGV Notification",
      theme: Style.themeData,
      home: HomeScreen(),
      navigatorKey: navigatorKey,
      initialRoute: initialRoute,
      routes: {
        '/morning': (_) => MorningScreen(),
        '/break': (_) => BreakScreen(),
      },
    );
  }
}
