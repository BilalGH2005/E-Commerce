import 'dart:async';

import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';
import '../../core/utils/async.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    _addAuthEventsListener();
    _checkIfNewUser();
    _themeMode();
    // PhotoManager.clearFileCache();
  }

  final _supabaseAuth = Supabase.instance.client.auth;
  late final StreamSubscription<AuthState> _authListener;
  // late final StreamSubscription<Uri?> _uriListener;
  bool? seenGettingStarted;
  bool? isDarkTheme = true;
  AsyncValue<List<Map<String, dynamic>>>? products;

  void _checkIfNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    seenGettingStarted = prefs.getBool('seenGettingStarted') ?? false;
  }

  void _themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
  }

  StreamSubscription<AuthState> _addAuthEventsListener() =>
      _authListener = _supabaseAuth.onAuthStateChange.listen((data) async {
        final AuthChangeEvent event = data.event;
        final BuildContext? context = AppRouter.navigatorKey.currentContext;
        if (context == null) return;
        if (event == AuthChangeEvent.signedIn) {
          if (seenGettingStarted!) {
            context.goNamed(ScreensNames.home);
          } else {
            context.goNamed(ScreensNames.gettingStarted);
          }
        } else if (event == AuthChangeEvent.signedOut) {
          context.goNamed(ScreensNames.signIn);
        }
      });

  void toggleTheme(bool? newValue) async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme = newValue;
    emit(AppThemeChanged());
    await prefs.setBool('isDarkTheme', newValue!);
  }

  // StreamSubscription<Uri?> _addUriListener() =>
  //     _uriListener = uriLinkStream.listen(
  //       (Uri? uri) async {
  //         final BuildContext? context = AppRouter.navigatorKey.currentContext;
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
