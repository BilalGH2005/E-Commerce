import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/auth/screens/terms_screen.dart';
import 'package:e_commerce/core/routes/navigation_bar.dart';
import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:e_commerce/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../admin/screens/admin_screen.dart';
import '../../app/screens/splash_screen.dart';
import '../../home/screens/getting_started_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../home/screens/profile_screen.dart';
import '../../home/screens/search_screen.dart';
import '../../home/screens/settings_screen.dart';

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
          name: ScreensNames.gettingStarted,
          path: ScreensNames.gettingStarted,
          builder: (context, state) => const GettingStartedScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return BottomNavBar(child: child);
          },
          routes: [
            GoRoute(
              name: ScreensNames.home,
              path: ScreensNames.home,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              name: ScreensNames.admin,
              path: ScreensNames.admin,
              builder: (context, state) => AdminScreen(),
            ),
            GoRoute(
              name: ScreensNames.search,
              path: ScreensNames.search,
              builder: (context, state) => const SearchScreen(),
            ),
            GoRoute(
              name: ScreensNames.profile,
              path: ScreensNames.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
            GoRoute(
              name: ScreensNames.settings,
              path: ScreensNames.settings,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
      redirect: (context, state) async {
        final supabaseAuth = Supabase.instance.client.auth;
        final prefs = await SharedPreferences.getInstance();
        bool? hasSeenOnBoarding = prefs.getBool('seenOnBoarding') ?? false;
        if (hasSeenOnBoarding == true) {
          final session = supabaseAuth.currentSession;
          if (session != null && session.isExpired) {
            await supabaseAuth.refreshSession();
            return ScreensNames.home;
          } else if (session != null &&
              !session.isExpired &&
              state.uri.path == ScreensNames.splash) {
            return ScreensNames.home;
          } else if (session == null && state.uri.path == ScreensNames.splash) {
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
