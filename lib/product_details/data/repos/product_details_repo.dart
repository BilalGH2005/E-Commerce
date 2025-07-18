import 'package:e_commerce/core/utils/auth_failure_mapper.dart';
import 'package:e_commerce/shop/data/models/filtered_products_model.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

abstract class ProductDetailsRepo {
  Future<AsyncResult<Product, String>> getProduct(String productId);
}

class SupabaseProductDetailsRepo implements ProductDetailsRepo {
  @override
  Future<AsyncResult<Product, String>> getProduct(String productId) async {
    return supabaseRpc('get_product_details',
        params: {'product_id': productId});
  }
}
