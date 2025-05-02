import 'dart:async';

import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/utils/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  final _supabaseAuth = Supabase.instance.client.auth;
  late final StreamSubscription<AuthState> _authListener;
  // late final StreamSubscription<Uri?> _uriListener;
  bool? seenGettingStarted;
  bool? isDarkTheme = false;
  bool? isArabic = false;
  AsyncValue<List<Map<String, dynamic>>>? products;

  Future<void> getAppDetails() async {
    final prefs = await SharedPreferences.getInstance();
    seenGettingStarted = prefs.getBool('seenGettingStarted') ?? false;
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    isArabic = prefs.getBool('isArabic') ?? false;
  }

  StreamSubscription<AuthState> addAuthEventsListener(BuildContext context) =>
      _authListener = _supabaseAuth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;

        if (event == AuthChangeEvent.signedIn) {
          context.goNamed(seenGettingStarted!
              ? ScreensNames.home
              : ScreensNames.gettingStarted);
          return;
        }

        if (event == AuthChangeEvent.signedOut) {
          context.goNamed(ScreensNames.signIn);
        }
      });

  Future<void> toggleTheme(bool? newValue) async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme = newValue;
    emit(AppThemeChanged());
    await prefs.setBool('isDarkTheme', isDarkTheme!);
  }

  Future<void> localeValue(String? newValue) async {
    final prefs = await SharedPreferences.getInstance();
    isArabic = newValue != 'English';
    emit(AppThemeChanged());
    await prefs.setBool('isArabic', isArabic!);
  }

  // StreamSubscription<Uri?> _addUriListener() =>
  //     _uriListener = uriLinkStream.listen(
  //       (Uri? uri) async {
  //         if (context == null) return;
  //         context.goNamed(ScreensNames.signIn);
  //       },
  //     );

  @override
  Future<void> close() {
    _authListener.cancel();
    // _uriListener.cancel();
    return super.close();
  }
}
