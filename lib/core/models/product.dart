import 'package:e_commerce/core/models/json_size.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';
import 'json_color.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
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

  Product({
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
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs
