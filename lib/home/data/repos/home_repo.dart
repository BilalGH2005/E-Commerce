import 'package:flutter/cupertino.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shop/data/models/filtered_products_model.dart';

abstract class HomeRepo {
  Future<AsyncResult<List<Product>, void>> getProducts({
    required int pageSize,
    required int currentRangeStart,
  });

  Future<AsyncResult<int, String>> getTotalProductCount();
}

class SupabaseHomeRepo implements HomeRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<AsyncResult<List<Product>, void>> getProducts({
    required int pageSize,
    required int currentRangeStart,
  }) async {
    try {
      final nextPage = await _supabase
          .from('products')
          .select('*')
          .range(currentRangeStart, currentRangeStart + pageSize - 1);
      final convertedList = nextPage.map((e) => Product.fromJson(e)).toList();
      return AsyncResult.data(data: convertedList);
    } catch (exception) {
      debugPrint(exception.toString());
      return AsyncResult.error(error: null);
    }
  }

  @override
  Future<AsyncResult<int, String>> getTotalProductCount() async {
    final totalProductsCount =
        await _supabase.from('products').count(CountOption.exact);
    return AsyncResult.data(data: totalProductsCount);
  }
}
