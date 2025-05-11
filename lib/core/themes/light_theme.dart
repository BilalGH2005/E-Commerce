import 'package:e_commerce/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LightTheme {
  final Locale locale;

  LightTheme(this.locale);
  ThemeData get lightTheme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.lightPrimary,
        brightness: Brightness.light,
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          labelStyle: TextStyle(
              fontFamily:
                  locale.languageCode == 'ar' ? 'Tajawal' : 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.lightTertiaryFixed),
          floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return const TextStyle(
                  color: AppColors.lightPrimary, fontSize: 12);
            }
            return const TextStyle(
                color: AppColors.lightTertiaryFixed, fontSize: 12);
          }),
          fillColor: AppColors.lightSurfaceContainer,
          filled: true,
        ),
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColors.lightPrimary,
          secondary: AppColors.secondary,
          surface: AppColors.white,
          inverseSurface: AppColors.black,
          primaryFixed: AppColors.lightPrimaryFixed,
          onSurface: AppColors.black,
          surfaceContainer: AppColors.lightSurfaceContainer,
          onInverseSurface: AppColors.lightOnInverseSurface,
          tertiary: AppColors.lightTertiary,
          tertiaryFixed: AppColors.lightTertiaryFixed,
          tertiaryFixedDim: AppColors.lightTertiaryFixedDim,
          error: AppColors.red,
          errorContainer: AppColors.lightPrimary,
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
        color: AppColors.lightPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 34,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleLarge: TextStyle(
        fontFamily: headlineFontFamily,
        color: AppColors.secondary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    );
  }
}
