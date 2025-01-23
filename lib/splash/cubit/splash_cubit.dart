import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/cubit/app_cubit.dart';
import '../../auth/screens/sign_in_screen.dart';
import '../../home/screens/home_screen.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    print('SplashCubit instantiated');
    _loadingInitialSession();
  }
  final _supabaseAuth = Supabase.instance.client.auth;
  void _loadingInitialSession() async {
    final session = _supabaseAuth.currentSession;
    final BuildContext? context = AppCubit.navigatorKey.currentContext;
    if (session != null && session.isExpired) {
      await _supabaseAuth.refreshSession();
    }
    print(
        'THE SESSION IS EXIST -> ${(session != null).toString().toUpperCase()}');
    if (context == null) return;
    await Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      if (session != null && !session.isExpired) {
        context.pushReplacementNamed(HomeScreen.name);
      } else {
        context.pushReplacementNamed(SignInScreen.name);
      }
    });
  }
}
