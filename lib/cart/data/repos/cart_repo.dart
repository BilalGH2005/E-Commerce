import 'dart:async';

import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/models/product.dart';

abstract class CartRepo {
  Future<AsyncResult<List<Product>, void>> fetchCartItems();

  Future<AsyncResult<void, void>> addToCart({
    required Product product,
  });

  Future<AsyncResult<void, void>> removeFromCart({
    required Product product,
  });
}

class SupabaseCartRepo implements CartRepo {
  final _supabase = Supabase.instance.client;

  @override
  Future<AsyncResult<List<Product>, void>> fetchCartItems() async {
    try {
      final cartItems = await _supabase
          .from('shopping_cart_items')
          .select('*, products(*)')
          .eq('user_id', _supabase.auth.currentUser!.id);

      final convertedList = cartItems.map((e) => Product.fromJson(e)).toList();
      return AsyncResult.data(data: convertedList);
    } catch (_) {
      return AsyncResult.error(error: null);
    }
  }

  @override
  Future<AsyncResult<void, void>> addToCart({
    required Product product,
  }) async {
    try {
      await _supabase.from('cart_items').insert({
        "product_id": product.id,
        "user_id": _supabase.auth.currentUser!.id
      });
      return AsyncResult.data(data: null);
    } catch (_) {
      return AsyncResult.error(error: null);
    }
  }

  @override
  Future<AsyncResult<void, void>> removeFromCart({
    required Product product,
  }) async {
    try {
      await _supabase
          .from('cart_items')
          .delete()
          .eq(_supabase.auth.currentUser!.id, product.id);
      return AsyncResult.data(data: null);
    } catch (_) {
      return AsyncResult.error(error: null);
    }
  }
}
