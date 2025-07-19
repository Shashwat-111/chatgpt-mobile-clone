import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF000000);
  static const card = Color(0xFF1A1A1A);
  static const inputBackground = Color(0xFF1E1E1E);
  static const textPrimary = Color(0xFFEFEFEF);
  static const textSecondary = Color(0xFF888888);
  static const accent = Colors.white;

  static final chatGptDarkTheme = ThemeData(
    scaffoldBackgroundColor: background,
    primaryColor: accent,
    cardColor: card,

    inputDecorationTheme: const InputDecorationTheme(
      fillColor: inputBackground,
      filled: true,
      hintStyle: TextStyle(color: textSecondary),
      border: InputBorder.none,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textPrimary),
      bodySmall: TextStyle(color: textSecondary),
    ),

    iconTheme: const IconThemeData(color: accent, size: 18),

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700
      ),
    ),
  );
}
