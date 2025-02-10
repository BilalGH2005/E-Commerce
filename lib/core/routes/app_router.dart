import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/auth/screens/terms_screen.dart';
import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:e_commerce/home/screens/getting_started_screen.dart';
import 'package:e_commerce/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/screens/splash_screen.dart';
import '../../home/screens/home_screen.dart';

class AppRouter {
  late final GoRouter router;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  AppRouter() {
    router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: ScreensNames.splash,
      routes: <RouteBase>[
        GoRoute(
          name: ScreensNames.splash,
          path: ScreensNames.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: ScreensNames.onBoarding,
          path: ScreensNames.onBoarding,
          builder: (context, state) => const OnBoardingScreen(),
        ),
        GoRoute(
          name: ScreensNames.signIn,
          path: ScreensNames.signIn,
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          name: ScreensNames.signUp,
          path: ScreensNames.signUp,
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          name: ScreensNames.resetPassword,
          path: ScreensNames.resetPassword,
          builder: (context, state) => ResetPasswordScreen(),
        ),
        GoRoute(
          name: ScreensNames.terms,
          path: ScreensNames.terms,
          builder: (context, state) => const TermsScreen(),
        ),
        GoRoute(
          name: ScreensNames.home,
          path: ScreensNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: ScreensNames.gettingStarted,
          path: ScreensNames.gettingStarted,
          builder: (context, state) => const GettingStartedScreen(),
        ),
      ],
      redirect: (context, state) async {
        final GoTrueClient supabaseAuth = Supabase.instance.client.auth;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? hasSeenOnBoarding = prefs.getBool('hasSeenOnBoarding') ?? false,
            hasSeenGettingStarted =
                prefs.getBool('hasSeenGettingStarted') ?? false;
        if (hasSeenOnBoarding == true) {
          final Session? session = supabaseAuth.currentSession;
          if (session != null && session.isExpired) {
            await supabaseAuth.refreshSession();
          }
          if (session != null &&
              !session.isExpired &&
              state.uri.path == ScreensNames.splash) {
            print(hasSeenGettingStarted.toString());
            if (hasSeenGettingStarted) {
              return ScreensNames.home;
            } else {
              return ScreensNames.gettingStarted;
            }
          }
          if (session == null && state.uri.path == ScreensNames.splash) {
            return ScreensNames.signIn;
          }
        } else if (hasSeenOnBoarding == false &&
            state.uri.path == ScreensNames.splash) {
          return ScreensNames.onBoarding;
        }
        return null;
      },
    );
  }
}
