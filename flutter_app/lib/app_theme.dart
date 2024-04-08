import 'package:flutter/material.dart';

class AppTheme {
  // Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme(
      background: Colors.black,
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      onBackground: Colors.white,
      surface: Colors.grey,
      onSurface: Colors.white,
      brightness: Brightness.dark,
    ),
  );

  // Light theme
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(background: Colors.white));
}
