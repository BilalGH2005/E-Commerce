import 'package:e_commerce/admin/screens/admin_screen.dart';
import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/app/screens/splash_screen.dart';
import 'package:e_commerce/auth/screens/auth_screen.dart';
import 'package:e_commerce/auth/screens/reset_password_form_screen.dart';
import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/terms_screen.dart';
import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/widgets/responsive_bar.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/screens/getting_started_screen.dart';
import 'package:e_commerce/home/screens/home_screen.dart';
import 'package:e_commerce/home/screens/product_screen.dart';
import 'package:e_commerce/home/screens/profile_screen.dart';
import 'package:e_commerce/home/screens/search_screen.dart';
import 'package:e_commerce/home/screens/settings_screen.dart';
import 'package:e_commerce/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:supabase_flutter/supabase_flutter.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _searchNavigatorKey = GlobalKey<NavigatorState>();
final _adminNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();
final _settingsNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: ScreensNames.splash,
  routes: <RouteBase>[
    GoRoute(
      name: ScreensNames.splash,
      path: ScreensNames.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      name: ScreensNames.onBoarding,
      path: ScreensNames.onBoarding,
      builder: (_, __) => const OnBoardingScreen(),
    ),
    GoRoute(
      name: ScreensNames.auth,
      path: ScreensNames.auth,
      builder: (_, __) => AuthScreen(),
    ),
    GoRoute(
      name: ScreensNames.resetPassword,
      path: ScreensNames.resetPassword,
      builder: (_, state) => ResetPasswordScreen(),
    ),
    GoRoute(
      name: ScreensNames.resetPasswordForm,
      path: ScreensNames.resetPasswordForm,
      builder: (_, state) => const ResetPasswordFormScreen(),
    ),
    GoRoute(
      name: ScreensNames.terms,
      path: ScreensNames.terms,
      builder: (_, __) => const TermsScreen(),
    ),
    GoRoute(
      name: ScreensNames.gettingStarted,
      path: ScreensNames.gettingStarted,
      builder: (_, __) => const GettingStartedScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (_, __, navigationShell) => ResponsiveBar(navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              name: ScreensNames.home,
              path: ScreensNames.home,
              builder: (_, __) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _searchNavigatorKey,
          routes: [
            GoRoute(
              name: ScreensNames.search,
              path: ScreensNames.search,
              builder: (_, __) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _adminNavigatorKey,
          routes: [
            GoRoute(
              name: ScreensNames.admin,
              path: ScreensNames.admin,
              builder: (_, __) => AdminScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              name: ScreensNames.profile,
              path: ScreensNames.profile,
              builder: (_, __) => ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              name: ScreensNames.settings,
              path: ScreensNames.settings,
              builder: (_, __) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: ScreensNames.product,
      path: ScreensNames.product,
      builder: (_, state) => ProductScreen(product: state.extra as Product),
    ),
  ],
  redirect: (context, state) {
    debugPrint('REDIRECT INVOKED');
    final appCubit = context.read<AppCubit>();

    if (!appCubit.isAuthenticated) return null;

    final seenOnBoarding = appCubit.seenOnBoarding;
    final seenGettingStarted = appCubit.seenGettingStarted;
    final session = Supabase.instance.client.auth.currentSession;

    if (state.uri.path != ScreensNames.splash) return null;

    if (!seenOnBoarding) return ScreensNames.onBoarding;

    if (session == null) return ScreensNames.auth;

    if (!seenGettingStarted) return ScreensNames.gettingStarted;

    return ScreensNames.home;
  },
);
