import 'dart:async';

import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final prefs = serviceLocator<SharedPreferences>();

  // dummy assignments until app get fully initialized
  bool seenOnBoarding = false;
  bool seenGettingStarted = false;
  bool isDarkTheme = false;
  bool isArabic = false;

  AppCubit() : super(AppInitial()) {
    _getInitialData();
  }

  Future<void> _getInitialData() async {
    seenOnBoarding = prefs.getBool('seenOnBoarding') ?? false;
    seenGettingStarted = prefs.getBool('seenGettingStarted') ?? false;
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    isArabic = prefs.getBool('isArabic') ?? false;

    emit(GotAppInitialData());
  }

  Future<void> hasSeenOnBoarding() async {
    await prefs.setBool('seenOnBoarding', true);
    seenOnBoarding = true;
    emit(AppDataChanged());
  }

  Future<void> hasSeenGettingStarted() async {
    await prefs.setBool('seenGettingStarted', true);
    seenGettingStarted = true;
    emit(AppDataChanged());
  }

  Future<void> toggleTheme(bool? newValue) async {
    isDarkTheme = newValue ?? false;
    await prefs.setBool('isDarkTheme', isDarkTheme);
    emit(AppDataChanged());
  }

  Future<void> localeValue(String? newValue) async {
    isArabic = newValue != 'English';
    await prefs.setBool('isArabic', isArabic);
    emit(AppDataChanged());
  }
}
