import 'package:e_commerce/core/utils/auth_failure_mapper.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

import '../model/product_details_model.dart';

abstract class ProductDetailsRepo {
  Future<AsyncResult<ProductDetailsModel, String>> getProduct(String productId);
}

class SupabaseProductDetailsRepo implements ProductDetailsRepo {
  @override
  Future<AsyncResult<ProductDetailsModel, String>> getProduct(
    String productId,
  ) async {
    return supabaseRpc(
      'get_product_details',
      params: {'product_id': productId},
      fromJson: (json) => ProductDetailsModel.fromJson(json),
      get: true,
    );
  }
}
