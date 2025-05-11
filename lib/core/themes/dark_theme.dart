import 'package:e_commerce/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DarkTheme {
  final Locale locale;

  DarkTheme(this.locale);
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.darkSurface,
        primaryColor: AppColors.darkPrimary,
        brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          labelStyle: TextStyle(
              fontFamily:
                  locale.languageCode == 'ar' ? 'Tajawal' : 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.darkTertiaryFixed),
          floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return const TextStyle(
                  color: AppColors.darkPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w300);
            }
            return const TextStyle(
                color: AppColors.darkTertiaryFixed,
                fontSize: 12,
                fontWeight: FontWeight.w300);
          }),
          fillColor: AppColors.darkSurfaceContainer,
          filled: true,
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.darkPrimary,
          secondary: AppColors.secondary,
          surface: AppColors.darkSurface,
          inverseSurface: AppColors.white,
          primaryFixed: AppColors.darkPrimaryFixed,
          onSurface: AppColors.white,
          surfaceContainer: AppColors.darkSurfaceContainer,
          onInverseSurface: AppColors.white,
          tertiary: AppColors.darkTertiary,
          tertiaryFixed: AppColors.darkTertiaryFixed,
          tertiaryFixedDim: AppColors.darkTertiaryFixedDim,
          error: AppColors.red,
          errorContainer: AppColors.darkPrimary,
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
        color: AppColors.darkPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
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
        color: AppColors.black,
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
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    );
  }
}
