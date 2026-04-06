import 'package:dio/dio.dart';
import 'package:e_commerce/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/auth/presentation/controllers/auth_cubit.dart';
import 'package:e_commerce/collection/data/repos/collection_repo.dart';
import 'package:e_commerce/payment/presentation/controllers/payment_cubit.dart';
import 'package:e_commerce/product_details/data/repos/product_details_repo.dart';
import 'package:e_commerce/shop/data/repos/shop_repo.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cart/data/repos/cart_repo.dart';
import '../../cart/presentation/controllers/cart_cubit.dart';
import '../../home/data/repos/home_repo.dart';
import '../../payment/data/repos/payment_repo.dart';
import '../../shop/presentation/controllers/shop_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Repos
  serviceLocator.registerLazySingleton<AuthRepo>(() => SupabaseAuthRepo());
  serviceLocator.registerLazySingleton<HomeRepo>(() => SupabaseHomeRepo());
  serviceLocator.registerLazySingleton<CartRepo>(() => SupabaseCartRepo());
  serviceLocator.registerLazySingleton<ShopRepo>(() => SupabaseShopRepo());
  serviceLocator.registerLazySingleton<PaymentRepo>(() => StripePaymentRepo());
  serviceLocator.registerLazySingleton<ProductDetailsRepo>(
    () => SupabaseProductDetailsRepo(),
  );
  serviceLocator.registerLazySingleton<CollectionRepo>(
    () => SupabaseCollectionRepo(),
  );

  // Cubits
  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(serviceLocator<AuthRepo>()),
    dispose: (cubit) => cubit.close(),
  );
  serviceLocator.registerLazySingleton<ShopCubit>(
    () => ShopCubit(serviceLocator<ShopRepo>()),
    dispose: (cubit) => cubit.close(),
  );
  serviceLocator.registerLazySingleton<CartCubit>(
    () => CartCubit(serviceLocator<CartRepo>()),
    dispose: (cubit) => cubit.close(),
  );
  serviceLocator.registerLazySingleton<PaymentCubit>(
    () => PaymentCubit(serviceLocator<PaymentRepo>()),
    dispose: (cubit) => cubit.close(),
  );

  serviceLocator.registerSingletonAsync(() => SharedPreferences.getInstance());
  serviceLocator.registerLazySingleton<Stripe>(() => Stripe.instance);
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
}
