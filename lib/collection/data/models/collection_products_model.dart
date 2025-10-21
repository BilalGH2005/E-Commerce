import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/product_preview.dart';

@JsonSerializable()
class CollectionProductsModel {
  final List<ProductPreview> products;

  CollectionProductsModel({required this.products});

  factory CollectionProductsModel.fromJson(dynamic json) {
    final list = (json as List<dynamic>)
        .map((item) => ProductPreview.fromJson(item as Map<String, dynamic>))
        .toList();
    return CollectionProductsModel(products: list);
  }

  Map<String, dynamic> toJson() => {
    "products": products.map((e) => e.toJson()).toList(),
  };
}
