import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/terms_screen.dart';
import 'package:e_commerce/core/routes/navigation_bar.dart';
import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:e_commerce/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../admin/screens/admin_screen.dart';
import '../../app/screens/splash_screen.dart';
import '../../auth/screens/sign_in_screen.dart';
import '../../auth/screens/sign_up_screen.dart';
import '../../home/models/product.dart';
import '../../home/screens/getting_started_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../home/screens/product_screen.dart';
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
      initialLocation: ScreensNames.search,
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
          builder: (context, state, child) => NavigationBars(child: child),
          routes: [
            GoRoute(
              name: ScreensNames.home,
              path: ScreensNames.home,
              builder: (context, state) => HomeScreen(),
            ),
            GoRoute(
              name: ScreensNames.search,
              path: ScreensNames.search,
              builder: (context, state) => const SearchScreen(),
            ),
            GoRoute(
              name: ScreensNames.admin,
              path: ScreensNames.admin,
              builder: (context, state) => AdminScreen(),
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
        GoRoute(
          name: ScreensNames.product,
          path: ScreensNames.product,
          builder: (context, state) {
            return ProductScreen(product: state.extra as Product);
          },
        ),
      ],
      // TODO: force splash screen to appear
      // redirect: (context, state) async {
      //   if (state.uri.path != ScreensNames.splash) return null;
      //
      //   final prefs = await SharedPreferences.getInstance();
      //   final seenOnBoarding = prefs.getBool('seenOnBoarding') ?? false;
      //   if (!seenOnBoarding) return ScreensNames.onBoarding;
      //
      //   final supabaseAuth = Supabase.instance.client.auth;
      //   final currentSession = supabaseAuth.currentSession;
      //
      //   if (currentSession == null) {
      //     return ScreensNames.signIn;
      //   }
      //
      //   if (currentSession.isExpired) {
      //     try {
      //       await supabaseAuth.refreshSession();
      //     } catch (_) {
      //       return ScreensNames.signIn;
      //     }
      //   }
      //   return ScreensNames.home;
      // },
    );
  }
}
