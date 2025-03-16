import 'package:flutter/material.dart';

class LightTheme {
  final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light().copyWith(
      primary: Color(0xFFF83758),
      secondary: Color(0xFF4392F9),
      surface: Colors.white,
      inverseSurface: Colors.black,
      onPrimary: Color(0xFFFF4B26),
      onSurface: Color(0xFFF3F3F3),
      onInverseSurface: Color(0xFF17223B),
      tertiary: Color(0xFFA0A0A1),
    ),
    textTheme: TextTheme().copyWith(
      headlineLarge: TextStyle(
        fontFamily: 'LibreCaslonText',
        color: Color(0xFFF83758),
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 36,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleLarge: TextStyle(
        fontFamily: 'LibreCaslonText',
        color: Color(0xFF4392F9),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
        height: 1.5,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xFF575757),
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xFF676767),
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    ),
  );
}
