import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/auth/presentation/screens/auth_screen.dart';
import 'package:e_commerce/auth/presentation/screens/forget_password_screen.dart';
import 'package:e_commerce/auth/presentation/screens/reset_password_screen.dart';
import 'package:e_commerce/auth/presentation/screens/terms_screen.dart';
import 'package:e_commerce/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/cart/data/repos/cart_repo.dart';
import 'package:e_commerce/collection/cubit/collection_cubit.dart';
import 'package:e_commerce/collection/data/repos/collection_repo.dart';
import 'package:e_commerce/core/router/temp_screen.dart';
import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:e_commerce/core/widgets/app_responsive_bar.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/presentation/screens/getting_started_screen.dart';
import 'package:e_commerce/home/presentation/screens/home_screen.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:e_commerce/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:e_commerce/profile/cubit/profile_cubit.dart';
import 'package:e_commerce/profile/data/repos/profile_repo.dart';
import 'package:e_commerce/profile/presentation/screens/profile_screen.dart';
import 'package:e_commerce/settings/presentation/screens/settings_screen.dart';
import 'package:e_commerce/shop/presentation/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../cart/presentation/screens/cart_screen.dart';
import '../../collection/presentation/screens/collection_screen.dart';
import '../../home/data/repos/home_repo.dart';
import '../../product_details/cubit/product_details_cubit.dart';
import '../../product_details/data/repos/product_details_repo.dart';
import '../../product_details/presentation/screens/product_details_screen.dart';
import '../../settings/cubit/settings_cubit.dart';
import '../../shop/cubit/shop_cubit.dart';
import '../constants/app_routes.dart';
import '../cubit/app_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: navigatorKey,
  initialLocation: AppRoutes.home.path,
  // initialLocation: AppRoutes.shop.path,
  routes: <RouteBase>[
    GoRoute(
      name: AppRoutes.temp.name,
      path: AppRoutes.temp.path,
      builder: (_, _) => TempScreen(),
    ),
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
      builder: (_, _) => BlocProvider(
        create: (_) => AuthCubit(serviceLocator<AuthRepo>()),
        child: AuthScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.forgetPassword.name,
      path: AppRoutes.forgetPassword.path,
      builder: (_, state) => BlocProvider.value(
        // providing cubit with extra is not gonna work on web when navigate via link
        value: state.extra as AuthCubit,
        child: ForgetPasswordScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.resetPassword.name,
      path: AppRoutes.resetPassword.path,
      builder: (_, state) => BlocProvider.value(
        value: state.extra as AuthCubit,
        child: ResetPasswordScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.terms.name,
      path: AppRoutes.terms.path,
      builder: (_, _) => const TermsScreen(),
    ),
    GoRoute(
      name: AppRoutes.gettingStarted.name,
      path: AppRoutes.gettingStarted.path,
      builder: (_, _) => const GettingStartedScreen(),
    ),
    GoRoute(
      name: AppRoutes.productDetails.name,
      path: AppRoutes.productDetails.path,
      builder: (_, state) => BlocProvider(
        create: (_) => ProductDetailsCubit(
          productDetailsRepo: serviceLocator<ProductDetailsRepo>(),
          productId: state.pathParameters['product_id'] ?? '',
        ),
        child: ProductDetailsScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.collection.name,
      path: AppRoutes.collection.path,
      builder: (_, state) => BlocProvider(
        create: (_) => CollectionCubit(
          collectionRepo: serviceLocator<CollectionRepo>(),
          collectionId: state.pathParameters['collection_id'] ?? '',
        ),
        child: CollectionScreen(),
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
              builder: (_, _) => BlocProvider(
                create: (context) => CartCubit(serviceLocator<CartRepo>()),
                child: CartScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.profile.name,
              path: AppRoutes.profile.path,
              builder: (_, _) => BlocProvider(
                create: (context) =>
                    ProfileCubit(serviceLocator<ProfileRepo>()),
                child: ProfileScreen(),
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
    final whiteListPaths = {
      AppRoutes.onBoarding.path,
      AppRoutes.auth.path,
      AppRoutes.forgetPassword.path,
      AppRoutes.terms.path,
    };

    final appCubit = context.read<AppCubit>();
    final seenOnBoarding = appCubit.seenOnBoarding;
    final seenGettingStarted = appCubit.seenGettingStarted;
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;
    final isWhiteListPath = whiteListPaths.contains(state.uri.path);
    debugPrint('HERE 1');
    // Redirect logged-in users away from onboarding/auth pages to home
    if (isWhiteListPath && isLoggedIn) return AppRoutes.home.path;
    debugPrint('HERE 2');
    // Allow access to whitelisted routes for non-logged-in users
    if (isWhiteListPath) return null;
    debugPrint('HERE 3');
    if (!seenOnBoarding) return AppRoutes.onBoarding.path;
    debugPrint('HERE 4');
    if (!isLoggedIn) return AppRoutes.auth.path;
    debugPrint('HERE 5');
    if (!seenGettingStarted) return AppRoutes.gettingStarted.path;
    debugPrint('HERE 6');
    return null;
  },
);
