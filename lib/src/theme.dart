import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // JalSetu Brand Colors
  static const Color jalSetuPrimaryBlue = Color(0xFF0077B6); // Deep Blue (Primary)
  static const Color jalSetuTeal = Color(0xFF00B4D8); // Teal (Accent/Secondary)
  static const Color jalSetuBackground = Color(0xFFF1F5F9); // Light Slate Gray

  static final ThemeData lightTheme = ThemeData(
    // 1. Base Colors and Background
    primaryColor: jalSetuPrimaryBlue,
    scaffoldBackgroundColor: jalSetuBackground,
    colorScheme: ColorScheme.light(
      primary: jalSetuPrimaryBlue,
      secondary: jalSetuTeal,
      surface: Colors.white,
      background: jalSetuBackground,
      error: const Color(0xFFEF4444), // Red for errors
      onPrimary: Colors.white,
      onSurface: const Color(0xFF1E293B), // Dark text color
      onBackground: const Color(0xFF1E293B),
    ),
    
    // 2. Typography
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      displayLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: jalSetuPrimaryBlue),
      titleMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
      bodyLarge: const TextStyle(fontSize: 16, color: Color(0xFF475569)),
      labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),

    // 3. Input Fields (Borderless, White Background)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), // Highly rounded
        borderSide: BorderSide.none, // Removes the standard border line
      ),
      hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
      focusedBorder: OutlineInputBorder( // Optional: Add a slight border when focused
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: jalSetuTeal, width: 2),
      ),
    ),

    // 4. Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56), // Full width and height
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: jalSetuPrimaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}