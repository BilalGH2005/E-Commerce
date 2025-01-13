import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../home/screens/home_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    _addListener();
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late final StreamSubscription<AuthState> authListener;
  void _addListener() {
    authListener =
        Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      print(event);
      if (navigatorKey.currentContext == null) return;
      //TODO: imp(3) - make the whole navigation system
      switch (event) {
        case AuthChangeEvent.initialSession:
        case AuthChangeEvent.signedIn:
          Navigator.pushNamedAndRemoveUntil(
              navigatorKey.currentContext!, HomeScreen.id, (route) => false);
        case AuthChangeEvent.signedOut:
        case AuthChangeEvent.passwordRecovery:
        default:
      }
    });
  }

  @override
  Future<void> close() {
    authListener.cancel();
    return super.close();
  }
}
