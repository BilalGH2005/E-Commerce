import 'package:e_commerce/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/cart/data/repos/cart_repo.dart';
import 'package:e_commerce/collection/data/repos/collection_repo.dart';
import 'package:e_commerce/product_details/data/repos/product_details_repo.dart';
import 'package:e_commerce/shop/data/repos/shop_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/data/repos/home_repo.dart';
import '../../profile/data/repos/profile_repo.dart';
import '../../shop/cubit/shop_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setupDependencyInjection() async {
  serviceLocator.registerLazySingleton<AuthRepo>(() => SupabaseAuthRepo());
  serviceLocator.registerLazySingleton<HomeRepo>(() => SupabaseHomeRepo());
  serviceLocator.registerLazySingleton<CartRepo>(() => SupabaseCartRepo());
  serviceLocator.registerLazySingleton<ShopRepo>(() => SupabaseShopRepo());
  serviceLocator.registerLazySingleton<ShopCubit>(
    () => ShopCubit(serviceLocator<ShopRepo>()),
    dispose: (cubit) => cubit.close(),
  );
  serviceLocator.registerLazySingleton<ProfileRepo>(
    () => SupabaseProfileRepo(),
  );
  serviceLocator.registerLazySingleton<ProductDetailsRepo>(
    () => SupabaseProductDetailsRepo(),
  );
  serviceLocator.registerLazySingleton<CollectionRepo>(
    () => SupabaseCollectionRepo(),
  );

  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(prefs);
}
