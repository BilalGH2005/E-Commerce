import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final prefs = serviceLocator<SharedPreferences>();
  static const _themeModeKey = 'themeMode';
  static const _localeKey = 'locale';
  static const _seenOnBoardingKey = 'seenOnBoarding';
  static const _seenGettingStartedKey = 'seenGettingStarted';

  // dummy assignments until app get fully initialized
  bool seenOnBoarding = false;
  bool seenGettingStarted = false;
  ThemeMode themeMode = ThemeMode.system;
  Locale? locale;

  AppCubit() : super(AppInitial()) {
    _getInitialData();
  }

  Future<void> _getInitialData() async {
    seenOnBoarding = prefs.getBool(_seenOnBoardingKey) ?? false;
    seenGettingStarted = prefs.getBool(_seenGettingStartedKey) ?? false;
    themeMode = _storedThemeMode();
    locale = _storedLocale();

    emit(GotAppInitialData());
  }

  Future<void> hasSeenOnBoarding() async {
    await prefs.setBool(_seenOnBoardingKey, true);
    seenOnBoarding = true;
    emit(AppDataChanged());
  }

  Future<void> hasSeenGettingStarted() async {
    await prefs.setBool(_seenGettingStartedKey, true);
    seenGettingStarted = true;
    emit(AppDataChanged());
  }

  ThemeMode _storedThemeMode() {
    final storedValue = prefs.getString(_themeModeKey);
    if (storedValue != null) {
      switch (storedValue) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        default:
          return ThemeMode.system;
      }
    }
    return ThemeMode.system;
  }

  Future<void> setThemeMode(String? newValue) async {
    themeMode = switch (newValue) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    await prefs.setString(_themeModeKey, switch (themeMode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });

    emit(AppDataChanged());
  }

  Locale? _storedLocale() {
    final storedValue = prefs.getString(_localeKey);
    if (storedValue != null) {
      switch (storedValue) {
        case 'en':
          return const Locale('en');
        case 'ar':
          return const Locale('ar');
        default:
          return null;
      }
    }

    return null;
  }

  Future<void> setLocale(String? newValue) async {
    locale = switch (newValue) {
      'en' => const Locale('en'),
      'ar' => const Locale('ar'),
      _ => null,
    };

    await prefs.setString(_localeKey, switch (locale?.languageCode) {
      'en' => 'en',
      'ar' => 'ar',
      _ => 'system',
    });

    emit(AppDataChanged());
  }
}
