import 'dart:async';

import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    _addAuthEventsListener();
  }

  final _supabaseAuth = Supabase.instance.client.auth;
  late final StreamSubscription<AuthState> _authListener;
  // late final StreamSubscription<Uri?> _uriListener;

  StreamSubscription<AuthState> _addAuthEventsListener() =>
      _authListener = _supabaseAuth.onAuthStateChange.listen((data) async {
        final AuthChangeEvent event = data.event;
        final BuildContext? context = AppRouter.navigatorKey.currentContext;
        if (context == null) return;
        if (event == AuthChangeEvent.signedIn) {
          context.goNamed(ScreensNames.home);
        } else if (event == AuthChangeEvent.signedOut) {
          context.goNamed(ScreensNames.signIn);
        }
      });

  // StreamSubscription<Uri?> _addUriListener() =>
  //     _uriListener = uriLinkStream.listen(
  //       (Uri? uri) async {
  //         final BuildContext? context = navigatorKey.currentContext;
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
