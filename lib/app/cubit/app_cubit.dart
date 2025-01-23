import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';

import '../../core/utils/svg_util.dart';
import '../../home/screens/home_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    print('AppCubit instantiated');
    SvgUtil.preLoadSvgImages(['assets/images/app_logo.svg']);
    _addAuthListener();
    // _addUriListener();
  }
  final _supabaseAuth = Supabase.instance.client.auth;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  late final StreamSubscription<AuthState> _authListener;
  late final StreamSubscription<Uri?> _uriListener;

  StreamSubscription<AuthState> _addAuthListener() =>
      _authListener = _supabaseAuth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        print('THE EVENT IS :::::: $event');
        final BuildContext? context = navigatorKey.currentContext;
        if (context == null) return;
        if (event == AuthChangeEvent.signedIn) {
          context.goNamed(HomeScreen.name);
        } else if (event == AuthChangeEvent.signedOut) {
          context.goNamed(SignInScreen.name);
        }
      });

  StreamSubscription<Uri?> _addUriListener() =>
      _uriListener = uriLinkStream.listen(
        (Uri? uri) async {
          print('Received deep link: $uri');
          if (uri == null) return;
          final queryParams = uri.queryParameters;
          if (queryParams.containsKey('code')) {
            print('OAuth code: ${queryParams['code']}');
            try {
              await _supabaseAuth.exchangeCodeForSession(queryParams['code']!);
              print('OAuth sign-in successful!');
            } catch (error) {
              print('Error exchanging code for session: $error');
            }
          } else {
            print('Redirect URI does not contain the "code" parameter.');
          }
        },
      );

  @override
  Future<void> close() {
    _authListener.cancel();
    _uriListener.cancel();
    return super.close();
  }
}
