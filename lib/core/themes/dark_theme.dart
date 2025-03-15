import 'package:flutter/material.dart';

class DarkTheme {
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark().copyWith(
      primary: Color(0xFF4166D5),
      secondary: Color(0xFF4392F9),
      surface: Color(0xFF292A2D),
      inverseSurface: Colors.white,
      onSurface: Color(0xFF0E1323),
      onPrimary: Color(0xFF3959B2),
      onInverseSurface: Colors.white,
      tertiary: Color(0xFFA0A0A1),
    ),
    scaffoldBackgroundColor: Color(0xFF0d1b2a),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'LibreCaslonText',
          color: Color(0xFF4392F9),
          fontSize: 18,
          fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          fontSize: 36),
      headlineMedium: TextStyle(
          color: Colors.white,
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
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          fontSize: 12),
    ),
  );
}
