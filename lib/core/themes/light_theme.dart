import 'package:flutter/material.dart';

class LightTheme {
  final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light().copyWith(
      primary: Color(0xFFF83758),
      secondary: Color(0xFF4392F9),
      surface: Colors.white,
      inverseSurface: Colors.black,
      onSurface: Color(0xFFF3F3F3),
      onPrimary: Color(0xFFFF4B26),
      onInverseSurface: Color(0xFF17223B),
      tertiary: Color(0xFFA0A0A1),
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme().copyWith(
      titleLarge: TextStyle(
          fontFamily: 'LibreCaslonText',
          color: Color(0xFF4392F9),
          fontSize: 18,
          fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 36),
      headlineMedium: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 18),
      bodyMedium: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 20),
      displayMedium: TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
      bodySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        color: Color(0xFF676767),
      ),
      labelSmall: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          fontSize: 12),
    ),
  );
}
