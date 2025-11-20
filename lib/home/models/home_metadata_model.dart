import 'package:e_commerce/core/models/product_preview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_metadata_model.g.dart';

@JsonSerializable()
class HomeMetadataModel {
  final List<Category> categories;
  @JsonKey(name: 'best_seller')
  final List<ProductPreview> bestSeller;
  final List<Collection> collections;
  @JsonKey(name: 'new_products')
  final List<ProductPreview> newProducts;

  HomeMetadataModel({
    required this.categories,
    required this.bestSeller,
    required this.collections,
    required this.newProducts,
  });

  factory HomeMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeMetadataModelToJson(this);
}

@JsonSerializable()
class Category {
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Collection {
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;

  Collection({required this.id, required this.name, required this.imageUrl});

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
