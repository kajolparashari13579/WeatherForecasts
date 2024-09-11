import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);

  static ThemeState get darkTheme => ThemeState(darkThemeConfig);
  static ThemeState get lightTheme => ThemeState(lightThemeConfig);
}

ThemeData darkThemeConfig = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.yellow,
  ).copyWith(secondary: Colors.yellow, brightness: Brightness.dark),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    ),
  ),
);

ThemeData lightThemeConfig = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  ).copyWith(secondary: Colors.teal, brightness: Brightness.light),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    ),
  ),
);
