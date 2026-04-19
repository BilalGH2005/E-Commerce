import 'package:e_commerce/auth/presentation/controllers/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/screens/auth_screen.dart';
import 'package:e_commerce/auth/presentation/screens/forget_password_screen.dart';
import 'package:e_commerce/cart/presentation/controllers/cart_cubit.dart';
import 'package:e_commerce/collection/presentation/controllers/collection_cubit.dart';
import 'package:e_commerce/collection/data/repos/collection_repo.dart';
import 'package:e_commerce/core/models/webview_page_args.dart';
import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:e_commerce/core/utils/transition_animations.dart';
import 'package:e_commerce/core/widgets/app_responsive_bar.dart';
import 'package:e_commerce/core/widgets/app_webview_page.dart';
import 'package:e_commerce/home/presentation/controllers/home_cubit.dart';
import 'package:e_commerce/home/presentation/screens/getting_started_screen.dart';
import 'package:e_commerce/home/presentation/screens/home_screen.dart';
import 'package:e_commerce/login_callback/presentation/screens/login_callback_screen.dart';
import 'package:e_commerce/onboarding/presentation/controllers/onboarding_cubit.dart';
import 'package:e_commerce/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:e_commerce/settings/presentation/screens/settings_screen.dart';
import 'package:e_commerce/shop/presentation/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/presentation/screens/reset_password_screen.dart';
import '../../login_callback/presentation/cubit/login_callback_cubit.dart';
import '../../payment/presentation/controllers/payment_cubit.dart';
import '../../cart/presentation/screens/cart_screen.dart';
import '../../collection/presentation/screens/collection_screen.dart';
import '../../home/data/repos/home_repo.dart';
import '../../product_details/data/repos/product_details_repo.dart';
import '../../product_details/presentation/controllers/product_details_cubit.dart';
import '../../product_details/presentation/screens/product_details_screen.dart';
import '../../settings/presentation/controllers/settings_cubit.dart';
import '../../settings/presentation/screens/profile_screen.dart';
import '../../shop/presentation/controllers/shop_cubit.dart';
import '../constants/app_links.dart';
import '../constants/app_routes.dart';
import '../controllers/app_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: navigatorKey,
  initialLocation: AppRoutes.home.path,
  redirect: (context, state) {
    final appCubit = context.read<AppCubit>();
    final seenOnBoarding = appCubit.seenOnBoarding;
    final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
    final seenGettingStarted = appCubit.seenGettingStarted;
    final isWhiteListPath = [
      AppRoutes.onBoarding.path,
      AppRoutes.auth.path,
      AppRoutes.forgetPassword.path,
      AppRoutes.resetPassword.path,
      AppRoutes.webview.path,
    ].any((path) => state.uri.path == path);

    if (state.uri.host == AppLinks.resetPasswordRedirectHost) {
      return AppRoutes.resetPassword.path;
    } else if (state.uri.host == AppLinks.signUpRedirectHost) {
      return AppRoutes.loginCallback.path;
    }

    if (!seenOnBoarding) return AppRoutes.onBoarding.path;

    if (!isLoggedIn && !isWhiteListPath) return AppRoutes.auth.path;

    if (isLoggedIn && !seenGettingStarted) return AppRoutes.gettingStarted.path;

    return null;
  },
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
      pageBuilder: (context, state) {
        return slideFadePage(
          child: BlocProvider.value(
            value: serviceLocator<AuthCubit>(),
            child: AuthScreen(),
          ),
          key: AppRoutes.auth.name,
        );
      },
    ),
    GoRoute(
      name: AppRoutes.forgetPassword.name,
      path: AppRoutes.forgetPassword.path,
      pageBuilder: (context, state) {
        return slideFadePage(
          child: BlocProvider.value(
            value: serviceLocator<AuthCubit>(),
            child: ForgetPasswordScreen(),
          ),
          key: AppRoutes.forgetPassword.name,
        );
      },
    ),
    GoRoute(
      name: AppRoutes.resetPassword.name,
      path: AppRoutes.resetPassword.path,
      pageBuilder: (context, state) {
        return slideFadePage(
          child: BlocProvider.value(
            value: serviceLocator<AuthCubit>(),
            child: ResetPasswordScreen(),
          ),
          key: AppRoutes.resetPassword.name,
        );
      },
    ),
    GoRoute(
      name: AppRoutes.loginCallback.name,
      path: AppRoutes.loginCallback.path,
      pageBuilder: (context, state) {
        return slideFadePage(
          child: BlocProvider(
            create: (context) => LoginCallbackCubit(),
            child: LoginCallbackScreen(),
          ),
          key: AppRoutes.loginCallback.name,
        );
      },
    ),
    GoRoute(
      name: AppRoutes.webview.name,
      path: AppRoutes.webview.path,
      pageBuilder: (context, state) {
        final args = state.extra as WebViewPageArgs;
        return slideFadePage(
          child: AppWebViewPage(url: args.url, title: args.title),
          key: '${AppRoutes.webview.name}/${args.url}',
        );
      },
    ),
    GoRoute(
      name: AppRoutes.gettingStarted.name,
      path: AppRoutes.gettingStarted.path,
      pageBuilder: (context, state) {
        return slideFadePage(
          child: const GettingStartedScreen(),
          key: AppRoutes.gettingStarted.name,
        );
      },
    ),
    GoRoute(
      name: AppRoutes.productDetails.name,
      path: AppRoutes.productDetails.path,
      pageBuilder: (context, state) {
        return slideFadePage(
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
          key:
              '${AppRoutes.productDetails.name}/${state.pathParameters['product_id']}',
        );
      },
    ),
    GoRoute(
      name: AppRoutes.collection.name,
      path: AppRoutes.collection.path,
      pageBuilder: (context, state) {
        return slideFadePage(
          child: BlocProvider(
            create: (_) => CollectionCubit(
              collectionRepo: serviceLocator<CollectionRepo>(),
              collectionId: state.pathParameters['collection_id'] ?? '',
            ),
            child: CollectionScreen(collectionName: state.extra as String),
          ),
          key:
              '${AppRoutes.collection.name}/${state.pathParameters['collection_id']}',
        );
      },
    ),
    GoRoute(
      name: AppRoutes.profile.name,
      path: AppRoutes.profile.path,
      pageBuilder: (context, state) {
        return slideFadePage(
          child: BlocProvider.value(
            value: serviceLocator<SettingsCubit>(),
            child: const ProfileScreen(),
          ),
          key: AppRoutes.profile.name,
        );
      },
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
                create: (context) {
                  return HomeCubit(serviceLocator<HomeRepo>());
                },
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
              builder: (_, _) {
                return BlocProvider.value(
                  value: serviceLocator<ShopCubit>(),
                  child: const ShopScreen(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.cart.name,
              path: AppRoutes.cart.path,
              builder: (_, _) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: serviceLocator<CartCubit>()),
                    BlocProvider.value(value: serviceLocator<PaymentCubit>()),
                  ],
                  child: CartScreen(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.settings.name,
              path: AppRoutes.settings.path,
              builder: (_, _) => BlocProvider.value(
                value: serviceLocator<SettingsCubit>(),
                child: const SettingsScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
