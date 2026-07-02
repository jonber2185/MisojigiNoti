import 'package:flutter/material.dart';

class Style {
  static final TextStyle defaultTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static final ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: defaultTextStyle,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      showUnselectedLabels: false,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(bodyMedium: defaultTextStyle),
  );
}
