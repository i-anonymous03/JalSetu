import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFF3F4F6), // Light Gray
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3B82F6), // Blue
      secondary: Color(0xFF6B7280), // Gray
      surface: Colors.white,
      background: Color(0xFFF3F4F6),
      error: Color(0xFFEF4444), // Red
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF111827), // Dark Gray / Black
      onBackground: Color(0xFF111827),
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      displayLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: const TextStyle(fontSize: 16),
      labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color(0xFF3B82F6), // Blue
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
