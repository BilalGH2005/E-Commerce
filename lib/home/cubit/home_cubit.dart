import 'package:e_commerce/core/utils/async.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/cart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final SupabaseClient _supabase = Supabase.instance.client;
  AsyncValue<List<Product>> products = AsyncValue.data(data: []);
  List<Product>? newProducts;
  AsyncValue<List<Product>>? cartProducts;
  AsyncValue<List<Product>> searchProductsList = AsyncValue.data(data: []);
  late Fuzzy _fuzzy;
  final TextEditingController searchController = TextEditingController();

  Future<void> fetchCartItems() async {
    cartProducts = AsyncValue.loading();
    emit(CartStateChanged());

    try {
      final response = await _supabase
          .from('cart_items')
          .select('*, products(*)')
          .eq('user_id', _supabase.auth.currentUser!.id);
      cartProducts = AsyncValue.data(
          data: (response as List)
              .map((item) => Product.fromProducts(item['products']))
              .toList());
    } catch (exception) {
      cartProducts = AsyncValue.error(error: exception.toString());
    } finally {
      emit(CartStateChanged());
    }
  }

  Future<void> addToCart(Product product) async {
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    try {
      await _supabase.from('cart_items').insert({
        "product_id": product.id,
        "user_id": _supabase.auth.currentUser!.id
      });
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.toString());
    }
  }

  Future<void> removeFromCart(Product product) async {
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    try {
      await _supabase
          .from('cart_items')
          .delete()
          .eq(_supabase.auth.currentUser!.id, product.id);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context!, exception.toString());
    }
  }

  Future<void> showCartDialog(BuildContext context) async => await showDialog(
        context: context,
        builder: (context) {
          return CartDialog();
        },
      );

  Future<void> fetchProducts() async {
    products = AsyncValue.loading();
    emit(HomeStateChanged());

    try {
      final response = await _supabase.from('products').select('*');
      products = AsyncValue.data(
          data:
              (response as List).map((e) => Product.fromProducts(e)).toList());
      getNewProducts();
    } catch (exception) {
      products = AsyncValue.error(error: exception.toString());
    } finally {
      emit(HomeStateChanged());
    }
  }

  List<Product>? getNewProducts() {
    return products.data!
        .where((product) => product.addedAt.isAfter(
              DateTime.now().subtract(const Duration(days: 30)),
            ))
        .toList();
  }

// ---------------------------------- Search Pane ---------------------------------- //
  Future<void> initializeFuzzySearch() async {
    _fuzzy = Fuzzy<Product>(
      products.data!,
      options: FuzzyOptions(
        keys: [
          WeightedKey<Product>(
            name: 'name',
            weight: 0.6,
            getter: (product) => product.name,
          ),
          WeightedKey<Product>(
            name: 'description',
            weight: 0.3,
            getter: (product) => product.description,
          ),
          WeightedKey<Product>(
            name: 'category',
            weight: 0.1,
            getter: (product) => product.category,
          ),
        ],
        threshold: 1,
      ),
    );
    searchProductsList = AsyncValue.data(data: products.data!);
    emit(SearchStateChanged());
  }

  void searchProducts(String query) {
    searchProductsList = AsyncValue.loading();
    emit(SearchStateChanged());

    try {
      final results = _fuzzy.search(query);
      searchProductsList =
          AsyncValue.data(data: results.map((e) => e.item as Product).toList());
    } catch (exception) {
      searchProductsList = AsyncValue.error(error: exception.toString());
    } finally {
      emit(SearchStateChanged());
    }
  }
}
