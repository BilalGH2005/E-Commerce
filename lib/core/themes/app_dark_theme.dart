import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/fonts.gen.dart';

class AppDarkTheme {
  final Locale locale;

  AppDarkTheme(this.locale);

  ThemeData get darkTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.darkSurface,
    primaryColor: AppColors.darkPrimary,
    brightness: Brightness.dark,
    chipTheme: ChipThemeData(
      color: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.darkPrimary;
        } else {
          return AppColors.darkSurfaceContainer;
        }
      }),
      elevation: 0.0,
      labelStyle: TextStyle(color: AppColors.darkTertiaryFixed),
      secondaryLabelStyle: TextStyle(color: AppColors.white),
      checkmarkColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    sliderTheme: SliderThemeData().copyWith(
      inactiveTrackColor: AppColors.darkTertiary,
      valueIndicatorColor: AppColors.darkPrimary,
      showValueIndicator: ShowValueIndicator.onDrag,
      valueIndicatorTextStyle: TextStyle(
        fontFamily: locale.languageCode == 'ar'
            ? FontFamily.tajawal
            : FontFamily.montserrat,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColors.white,
      ),
    ),
    switchTheme: SwitchThemeData().copyWith(
      thumbColor: WidgetStatePropertyAll(AppColors.white),
      trackOutlineWidth: WidgetStatePropertyAll(1.5),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData().copyWith(
      color: AppColors.darkPrimary,
      strokeWidth: 4,
      constraints: BoxConstraints.tight(Size(25, 25)),
    ),
    inputDecorationTheme: const InputDecorationTheme().copyWith(
      labelStyle: TextStyle(
        fontFamily: locale.languageCode == 'ar'
            ? FontFamily.tajawal
            : FontFamily.montserrat,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: AppColors.darkTertiaryFixed,
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return const TextStyle(
            color: AppColors.darkPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          );
        }
        return const TextStyle(
          color: AppColors.darkTertiaryFixed,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        );
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
    final String fontFamily = locale.languageCode == 'ar'
        ? FontFamily.tajawal
        : FontFamily.montserrat;

    return TextTheme(
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
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 28,
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
