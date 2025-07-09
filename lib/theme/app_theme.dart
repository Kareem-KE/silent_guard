import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF042D46),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF006a4e),
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 18,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontFamily: 'Agbalumo',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Monoton',
        fontSize: 23,
        fontWeight: FontWeight.w600,
        color: Color(0xFF006a4e),
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Color(0xFF006a4e),
      secondary: Color(0xFF555555),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
  );
}
