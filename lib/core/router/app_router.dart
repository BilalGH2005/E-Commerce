import 'package:e_commerce/auth/presentation/controllers/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/screens/auth_screen.dart';
import 'package:e_commerce/auth/presentation/screens/forget_password_screen.dart';
import 'package:e_commerce/auth/presentation/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/presentation/screens/terms_screen.dart';
import 'package:e_commerce/cart/presentation/controllers/cart_cubit.dart';
import 'package:e_commerce/collection/presentation/controllers/collection_cubit.dart';
import 'package:e_commerce/collection/data/repos/collection_repo.dart';
import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/core/widgets/app_responsive_bar.dart';
import 'package:e_commerce/home/presentation/controllers/home_cubit.dart';
import 'package:e_commerce/home/presentation/screens/getting_started_screen.dart';
import 'package:e_commerce/home/presentation/screens/home_screen.dart';
import 'package:e_commerce/onboarding/presentation/controllers/onboarding_cubit.dart';
import 'package:e_commerce/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:e_commerce/settings/presentation/screens/settings_screen.dart';
import 'package:e_commerce/shop/presentation/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../payment/presentation/controllers/payment_cubit.dart';
import '../../cart/presentation/screens/cart_screen.dart';
import '../../collection/presentation/screens/collection_screen.dart';
import '../../home/data/repos/home_repo.dart';
import '../../product_details/data/repos/product_details_repo.dart';
import '../../product_details/presentation/controllers/product_details_cubit.dart';
import '../../product_details/presentation/screens/product_details_screen.dart';
import '../../settings/presentation/controllers/settings_cubit.dart';
import '../../shop/presentation/controllers/shop_cubit.dart';
import '../constants/app_routes.dart';
import '../controllers/app_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoutes.home.path,
  routes: <RouteBase>[
    GoRoute(
      name: AppRoutes.onBoarding.name,
      path: AppRoutes.onBoarding.path,
      builder: (_, _) => BlocProvider(
        create: (_) => OnBoardingCubit(),
        child: OnBoardingScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.auth.name,
      path: AppRoutes.auth.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: 600.ms,
        key: ValueKey(AppRoutes.auth.name),
        child: BlocProvider.value(
          value: serviceLocator<AuthCubit>(),
          child: AuthScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      name: AppRoutes.forgetPassword.name,
      path: AppRoutes.forgetPassword.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: 600.ms,
        key: ValueKey(AppRoutes.forgetPassword.name),
        child: BlocProvider.value(
          value: serviceLocator<AuthCubit>(),
          child: ForgetPasswordScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease));

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      name: AppRoutes.resetPassword.name,
      path: AppRoutes.resetPassword.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: 600.ms,
        key: ValueKey(AppRoutes.resetPassword.name),
        child: BlocProvider.value(
          value: serviceLocator<AuthCubit>(),
          child: ResetPasswordScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scaleAnimation = Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation);
          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      name: AppRoutes.terms.name,
      path: AppRoutes.terms.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: 600.ms,
        key: ValueKey(AppRoutes.terms.name),
        child: const TermsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      name: AppRoutes.gettingStarted.name,
      path: AppRoutes.gettingStarted.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: 600.ms,
        key: ValueKey(AppRoutes.gettingStarted.name),
        child: const GettingStartedScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      name: AppRoutes.productDetails.name,
      path: AppRoutes.productDetails.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: 600.ms,
        key: ValueKey(
          '${AppRoutes.productDetails.name}/${state.pathParameters['product_id']}',
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => ProductDetailsCubit(
                productDetailsRepo: serviceLocator<ProductDetailsRepo>(),
                productId: state.pathParameters['product_id'] ?? '',
              ),
            ),
            BlocProvider.value(value: serviceLocator<CartCubit>()),
            BlocProvider.value(value: serviceLocator<PaymentCubit>()),
          ],
          child: ProductDetailsScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      name: AppRoutes.collection.name,
      path: AppRoutes.collection.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: 600.ms,
        key: ValueKey(
          '${AppRoutes.collection.name}/${state.pathParameters['collection_id']}',
        ),
        child: BlocProvider(
          create: (_) => CollectionCubit(
            collectionRepo: serviceLocator<CollectionRepo>(),
            collectionId: state.pathParameters['collection_id'] ?? '',
          ),
          child: CollectionScreen(collectionName: state.extra as String),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) => AppResponsiveBar(navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.home.name,
              path: AppRoutes.home.path,
              builder: (_, _) => BlocProvider(
                create: (context) => HomeCubit(serviceLocator<HomeRepo>()),
                child: const HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.shop.name,
              path: AppRoutes.shop.path,
              builder: (_, _) => BlocProvider.value(
                value: serviceLocator<ShopCubit>(),
                child: const ShopScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.cart.name,
              path: AppRoutes.cart.path,
              builder: (_, _) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: serviceLocator<CartCubit>()),
                  BlocProvider.value(value: serviceLocator<PaymentCubit>()),
                ],
                child: CartScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.settings.name,
              path: AppRoutes.settings.path,
              builder: (_, _) => BlocProvider(
                create: (context) => SettingsCubit(),
                child: const SettingsScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final appCubit = context.read<AppCubit>();
    final seenOnBoarding = appCubit.seenOnBoarding;
    final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
    final seenGettingStarted = appCubit.seenGettingStarted;

    if (!seenOnBoarding) return AppRoutes.onBoarding.path;
    if (!isLoggedIn) return AppRoutes.auth.path;
    if (!seenGettingStarted) return AppRoutes.gettingStarted.path;
    return null;
  },
);
