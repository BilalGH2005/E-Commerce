import 'dart:async';

import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  bool seenOnBoarding = false;
  bool seenGettingStarted = false;
  bool isDarkTheme = false;
  bool isArabic = false;

  AppCubit() : super(AppInitial()) {
    final sharedPreferences = serviceLocator<SharedPreferences>();
    seenOnBoarding = sharedPreferences.getBool('seenOnBoarding') ?? false;
    seenGettingStarted =
        sharedPreferences.getBool('seenGettingStarted') ?? false;
    isDarkTheme = sharedPreferences.getBool('isDarkTheme') ?? false;
    isArabic = sharedPreferences.getBool('isArabic') ?? false;
    emit(GotAppInitialData());
  }

  Future<void> hasSeenOnBoarding() async {
    await serviceLocator<SharedPreferences>().setBool('seenOnBoarding', true);
    emit(AppDataChanged());
  }

  Future<void> hasSeenGettingStarted() async {
    await serviceLocator<SharedPreferences>()
        .setBool('seenGettingStarted', true);
    emit(AppDataChanged());
  }

  Future<void> toggleTheme(bool? newValue) async {
    isDarkTheme = newValue ?? false;
    await serviceLocator<SharedPreferences>()
        .setBool('isDarkTheme', isDarkTheme);
    emit(AppDataChanged());
  }

  Future<void> localeValue(String? newValue) async {
    isArabic = newValue != 'English';
    await serviceLocator<SharedPreferences>().setBool('isArabic', isArabic);
    emit(AppDataChanged());
  }
}
