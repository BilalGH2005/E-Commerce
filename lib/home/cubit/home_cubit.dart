import 'package:e_commerce/core/utils/async.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/cart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/routes/app_router.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final SupabaseClient _supabase = Supabase.instance.client;
  AsyncValue<List<Map<String, dynamic>>>? products;
  AsyncValue<List<Product>> cartItems = AsyncValue.data(data: []);

  Future<void> fetchCartItems() async {
    products = AsyncValue.loading();
    emit(CartStateChanged());

    try {
      final response = await _supabase
          .from('cart_items')
          .select('*, products(*)')
          .eq('user_id', _supabase.auth.currentUser!.id);
      cartItems = AsyncValue.data(
          data: (response as List)
              .map((item) => Product.fromProducts(item['products']))
              .toList());
    } catch (exception) {
      products = AsyncValue.error(error: exception.toString());
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

  Future<void> showCartDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CartDialog();
      },
    );
  }

  Future<void> fetchProducts() async {
    products = AsyncValue.loading();
    emit(HomeStateChanged());

    try {
      final response = await _supabase.from('products').select('*');
      products = AsyncValue.data(data: response);
    } catch (exception) {
      products = AsyncValue.error(error: exception.toString());
    } finally {
      emit(HomeStateChanged());
    }
  }
}
