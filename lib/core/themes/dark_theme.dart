import 'package:flutter/material.dart';

class DarkTheme {
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color(0xFF0d1b2a),
    colorScheme: ColorScheme.dark().copyWith(
      primary: Color(0xFF4166D5),
      secondary: Color(0xFF4392F9),
      surface: Color(0xFF0d1b2a) /*Color(0xFF292A2D)*/,
      inverseSurface: Colors.white,
      onPrimary: Color(0xFF3959B2),
      onSurface: Color(0xFF0E1323),
      onInverseSurface: Colors.white,
      tertiary: Color(0xFFA0A0A1),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'LibreCaslonText',
        color: Color(0xFF4166D5),
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
        fontSize: 36,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
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
        color: Colors.white,
        fontWeight: FontWeight.bold,
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
        fontSize: 12,
        color: Color(0xFF676767),
      ),
      labelSmall: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    ),
  );
}
