import 'package:flutter/material.dart';

import 'const_colors.dart';

class LightTheme {
  final Locale locale;

  LightTheme(this.locale);
  ThemeData get lightTheme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: ConstColors.kWhite,
        primaryColor: ConstColors.kLightPrimary,
        colorScheme: const ColorScheme.light().copyWith(
          primary: ConstColors.kLightPrimary,
          secondary: ConstColors.kSecondary,
          surface: ConstColors.kWhite,
          inverseSurface: ConstColors.kBlack,
          primaryFixed: ConstColors.kLightPrimaryFixed,
          onSurface: ConstColors.kBlack,
          surfaceContainer: ConstColors.kLightSurfaceContainer,
          onInverseSurface: ConstColors.lightOnInverseSurface,
          tertiary: ConstColors.lightTertiary,
          tertiaryFixed: ConstColors.lightTertiaryFixed,
          tertiaryFixedDim: ConstColors.lightTertiaryFixedDim,
          error: ConstColors.kRed,
        ),
        textTheme: _getTextTheme(),
      );

  TextTheme _getTextTheme() {
    final String fontFamily =
        locale.languageCode == 'ar' ? 'Tajawal' : 'Montserrat';
    final String headlineFontFamily =
        locale.languageCode == 'ar' ? 'Tajawal' : 'LibreCaslonText';

    return const TextTheme().copyWith(
      headlineLarge: TextStyle(
        fontFamily: headlineFontFamily,
        color: ConstColors.kLightPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kBlack,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kWhite,
        fontWeight: FontWeight.w600,
        fontSize: 34,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kWhite,
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kWhite,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleLarge: TextStyle(
        fontFamily: headlineFontFamily,
        color: ConstColors.kSecondary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kBlack,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kBlack,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kBlack,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kBlack,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kBlack,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        color: ConstColors.kBlack,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    );
  }
}
