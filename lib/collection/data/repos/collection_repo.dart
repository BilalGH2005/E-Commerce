import 'package:e_commerce/core/models/product_preview.dart';
import 'package:e_commerce/core/utils/auth_failure_mapper.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

abstract class CollectionRepo {
  Future<AsyncResult<List<ProductPreview>, String>> getCollectionProducts(
    String collectionId,
  );
}

class SupabaseCollectionRepo implements CollectionRepo {
  @override
  Future<AsyncResult<List<ProductPreview>, String>> getCollectionProducts(
    String collectionId,
  ) async {
    return await supabaseRpc<List<ProductPreview>>(
      'get_collection_products',
      params: {'collection_id': collectionId},
      get: true,
      fromJson: (response) {
        final list = response as List<dynamic>;
        return list
            .map(
              (item) => ProductPreview.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }
}
