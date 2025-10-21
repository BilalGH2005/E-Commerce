import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/fonts.gen.dart';

class AppLightTheme {
  final Locale locale;

  AppLightTheme(this.locale);

  ThemeData get lightTheme => ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.lightPrimary,
    brightness: Brightness.light,
    chipTheme: ChipThemeData(
      color: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.lightPrimary;
        } else {
          return AppColors.lightSurfaceContainer;
        }
      }),
      elevation: 0.0,
      labelStyle: TextStyle(color: AppColors.lightTertiaryFixed),
      secondaryLabelStyle: TextStyle(color: AppColors.white),
      checkmarkColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    sliderTheme: SliderThemeData().copyWith(
      inactiveTrackColor: AppColors.lightTertiary,
      valueIndicatorColor: AppColors.lightPrimary,
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
      thumbColor: WidgetStatePropertyAll(AppColors.black),
      trackOutlineWidth: WidgetStatePropertyAll(1),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData().copyWith(
      color: AppColors.lightPrimary,
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
        color: AppColors.lightTertiaryFixed,
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return const TextStyle(
            color: AppColors.lightPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          );
        }
        return const TextStyle(
          color: AppColors.lightTertiaryFixed,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        );
      }),
      fillColor: AppColors.white,
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
    final String fontFamily = locale.languageCode == 'ar'
        ? FontFamily.tajawal
        : FontFamily.montserrat;

    return const TextTheme().copyWith(
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
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 28,
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
