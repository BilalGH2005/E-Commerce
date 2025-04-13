import 'package:flutter/material.dart';

abstract class ConstColors {
  // Common colors
  static const Color kSecondary = Color(0xFF4392F9);
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kBlack = Color(0xFF000000);
  static const Color kRed = Color(0xFFF44336);

  // Light Theme colors
  static const Color kLightPrimary = Color(0xFFF83758);
  static const Color kLightPrimaryFixed = Color(0xFFFF4B26);
  static const Color kLightSurfaceContainer = Color(0xFFF3F3F3);
  static const Color lightOnInverseSurface = Color(0xFF17223B);
  static const Color lightTertiary = Color(0xFFC4C4C4);
  static const Color lightTertiaryFixedDim = Color(0xFFA8A8A9);
  static const Color lightTertiaryFixed = Color(0xFF676767);

  // Dark Theme colors
  static const Color darkPrimary = Color(0xFF4166D5);
  static const Color darkPrimaryFixed = Color(0xFF3959B2);
  static const Color darkSurfaceContainer = Color(0xFF0E1323);
  static const Color darkSurface = Color(0xFF0d1b2a);
  static const Color darkTertiary = Color(0xFF676767);
  static const Color darkTertiaryFixedDim = Color(0xFFA8A8A9);
  static const Color darkTertiaryFixed = Color(0xFFC4C4C4);
}
