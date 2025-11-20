import 'dart:async';

import 'package:e_commerce/core/utils/auth_failure_mapper.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../product_details/model/order_details.dart';
import '../../models/cart_item_model.dart';

abstract class CartRepo {
  Future<AsyncResult<List<CartItem>, void>> getCartItems();

  Future<AsyncResult<void, void>> addToCart({
    required OrderDetails orderDetails,
  });

  Future<AsyncResult<void, void>> removeFromCart({
    required OrderDetails orderDetails,
  });

  Future<AsyncResult<void, void>> removeFromCartEntirely({
    required OrderDetails orderDetails,
  });

  Future<AsyncResult<double, void>> getCouponDiscount({
    required String couponCode,
  });
}

class SupabaseCartRepo implements CartRepo {
  final _supabase = Supabase.instance.client;

  @override
  Future<AsyncResult<List<CartItem>, void>> getCartItems() async {
    return await supabaseRpc(
      'get_cart_items',
      params: {'user_id': _supabase.auth.currentUser!.id},
      get: true,
      fromJson: (response) {
        final list = (response as List<dynamic>? ?? []);
        return list
            .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );
  }

  @override
  Future<AsyncResult<void, void>> addToCart({
    required OrderDetails orderDetails,
  }) async {
    return await supabaseRpc(
      'add_to_cart',
      params: {
        'user_id': _supabase.auth.currentUser!.id,
        'product_id': orderDetails.productId,
        'color_id': orderDetails.colorId,
        'size_id': orderDetails.sizeId,
      },
    );
  }

  @override
  Future<AsyncResult<void, void>> removeFromCart({
    required OrderDetails orderDetails,
  }) async {
    return await supabaseRpc(
      'remove_from_cart',
      params: {
        'user_id': _supabase.auth.currentUser!.id,
        'product_id': orderDetails.productId,
        'color_id': orderDetails.colorId,
        'size_id': orderDetails.sizeId,
      },
    );
  }

  @override
  Future<AsyncResult<void, void>> removeFromCartEntirely({
    required OrderDetails orderDetails,
  }) async {
    return await supabaseRpc(
      'remove_from_cart_entirely',
      params: {
        'user_id': _supabase.auth.currentUser!.id,
        'product_id': orderDetails.productId,
        'color_id': orderDetails.colorId,
        'size_id': orderDetails.sizeId,
      },
    );
  }

  @override
  Future<AsyncResult<double, void>> getCouponDiscount({
    required String couponCode,
  }) async {
    return await supabaseRpc(
      'get_coupon_discount',
      get: true,
      params: {'coupon_code': couponCode},
      fromJson: (json) => (json as num).toDouble(),
    );
  }
}
