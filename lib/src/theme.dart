import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF0D47A1), // A deep, trustworthy blue
    scaffoldBackgroundColor: Colors.grey[50],
    colorScheme: const ColorScheme(
      primary: Color(0xFF1565C0), // A slightly brighter blue for interactions
      secondary: Color(0xFF4CAF50), // Green for success and positive actions
      // FIX: Replaced deprecated 'background' with 'surface'.
      surface: Colors.white,
      error: Color(0xFFD32F2F), // Standard red for errors
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      // FIX: Replaced deprecated 'onBackground' with 'onSurface'.
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF0D47A1),
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    fontFamily: 'Roboto',
  );
}
