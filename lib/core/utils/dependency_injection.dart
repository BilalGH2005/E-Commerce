import 'package:e_commerce/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/cart/data/repos/cart_repo.dart';
import 'package:e_commerce/product_details/data/repos/product_details_repo.dart';
import 'package:e_commerce/shop/data/repos/shop_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/data/repos/home_repo.dart';
import '../../profile/data/repos/profile_repo.dart';

final serviceLocator = GetIt.instance;

Future<void> setupDependencyInjection() async {
  serviceLocator.registerLazySingleton<AuthRepo>(() => SupabaseAuthRepo());
  serviceLocator.registerLazySingleton<HomeRepo>(() => SupabaseHomeRepo());
  serviceLocator.registerLazySingleton<CartRepo>(() => SupabaseCartRepo());
  serviceLocator.registerLazySingleton<ShopRepo>(() => SupabaseShopRepo());
  serviceLocator
      .registerLazySingleton<ProfileRepo>(() => SupabaseProfileRepo());
  serviceLocator.registerLazySingleton<ProductDetailsRepo>(
      () => SupabaseProductDetailsRepo());

  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(prefs);
}
