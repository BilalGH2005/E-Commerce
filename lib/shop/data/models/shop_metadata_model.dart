import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/json_color.dart';
import '../../../core/models/json_size.dart';

part 'shop_metadata_model.g.dart';

@JsonSerializable()
class ShopMetadata {
  @JsonKey(name: "min_price")
  final double minPrice;

  @JsonKey(name: "max_price")
  final double maxPrice;

  @JsonKey(name: "categories")
  final List<SimpleCategory> categories;

  @JsonKey(name: "colors")
  final List<JsonColor> colors;

  @JsonKey(name: "sizes")
  final List<JsonSize> sizes;

  ShopMetadata({
    required this.minPrice,
    required this.maxPrice,
    required this.categories,
    required this.colors,
    required this.sizes,
  });

  factory ShopMetadata.fromJson(Map<String, dynamic> json) =>
      _$ShopMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ShopMetadataToJson(this);
}

@JsonSerializable()
class SimpleCategory {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  SimpleCategory({required this.id, required this.name});

  factory SimpleCategory.fromJson(Map<String, dynamic> json) =>
      _$SimpleCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleCategoryToJson(this);
}
