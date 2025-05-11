import 'dart:async';

import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  bool seenOnBoarding = false,
      seenGettingStarted = false,
      isDarkTheme = false,
      isArabic = false,
      isAuthenticated = false;

  Future<void> getAppInitialData() async {
    seenOnBoarding = sharedPreferences.getBool('seenOnBoarding') ?? false;
    seenGettingStarted =
        sharedPreferences.getBool('seenGettingStarted') ?? false;
    isDarkTheme = sharedPreferences.getBool('isDarkTheme') ?? false;
    isArabic = sharedPreferences.getBool('isArabic') ?? false;
    isAuthenticated = true;
    emit(GotAppInitialData());
  }

  Future<void> toggleTheme(bool? newValue) async {
    isDarkTheme = newValue ?? false;
    await sharedPreferences.setBool('isDarkTheme', isDarkTheme);
    emit(AppThemeChanged());
  }

  Future<void> localeValue(String? newValue) async {
    isArabic = newValue != 'English';
    await sharedPreferences.setBool('isArabic', isArabic);
    emit(AppLocaleChanged());
  }
}
