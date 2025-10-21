import 'package:e_commerce/core/models/json_size.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/category.dart';
import '../../../core/models/json_color.dart';
import '../../../core/models/product_preview.dart';

part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "final_price")
  final double finalPrice;
  @JsonKey(name: "added_at")
  final DateTime addedAt;
  @JsonKey(name: "images_urls")
  final List<String> imagesUrls;
  @JsonKey(name: "category")
  final Category category;
  @JsonKey(name: "colors")
  final List<JsonColor> colors;
  @JsonKey(name: "sizes")
  final List<JsonSize> sizes;
  @JsonKey(name: "similar_products")
  final List<ProductPreview> similarProducts;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.finalPrice,
    required this.addedAt,
    required this.imagesUrls,
    required this.category,
    required this.colors,
    required this.sizes,
    required this.similarProducts,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}
