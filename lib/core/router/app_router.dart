import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/auth/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/screens/sign_in_screen.dart';
import 'package:e_commerce/auth/screens/sign_up_screen.dart';
import 'package:e_commerce/auth/screens/terms_screen.dart';
import 'package:e_commerce/onboarding/screens/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

import '../../home/screens/home_screen.dart';
import '../../splash/screens/splash_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    navigatorKey: AppCubit.navigatorKey,
    initialLocation: SplashScreen.name,
    routes: <RouteBase>[
      GoRoute(
        name: SplashScreen.name,
        path: SplashScreen.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: OnBoardingScreen.name,
        path: OnBoardingScreen.name,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        name: SignInScreen.name,
        path: SignInScreen.name,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        name: SignUpScreen.name,
        path: SignUpScreen.name,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        name: ResetPasswordScreen.name,
        path: ResetPasswordScreen.name,
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        name: TermsScreen.name,
        path: TermsScreen.name,
        builder: (context, state) => const TermsScreen(),
      ),
      GoRoute(
        name: HomeScreen.name,
        path: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
