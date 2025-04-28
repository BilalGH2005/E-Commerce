import 'package:flutter/material.dart';

import 'const_colors.dart';

class DarkTheme {
  final Locale locale;

  DarkTheme(this.locale);
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ConstColors.darkSurface,
        primaryColor: ConstColors.darkPrimary,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: ConstColors.darkPrimary,
          secondary: ConstColors.secondary,
          surface: ConstColors.darkSurface,
          inverseSurface: ConstColors.white,
          primaryFixed: ConstColors.darkPrimaryFixed,
          onSurface: ConstColors.white,
          surfaceContainer: ConstColors.darkSurfaceContainer,
          onInverseSurface: ConstColors.white,
          tertiary: ConstColors.darkTertiary,
          tertiaryFixed: ConstColors.darkTertiaryFixed,
          tertiaryFixedDim: ConstColors.darkTertiaryFixedDim,
          error: ConstColors.red,
          errorContainer: ConstColors.darkPrimary,
        ),
        textTheme: _getTextTheme(),
      );

  TextTheme _getTextTheme() {
    final String fontFamily =
        locale.languageCode == 'ar' ? 'Tajawal' : 'Montserrat';
    final String headlineFontFamily =
        locale.languageCode == 'ar' ? 'Tajawal' : 'LibreCaslonText';

    return TextTheme(
      headlineLarge: TextStyle(
        fontFamily: headlineFontFamily,
        color: ConstColors.darkPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 34,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.black,
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleLarge: TextStyle(
        fontFamily: headlineFontFamily,
        color: ConstColors.secondary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    );
  }
}
