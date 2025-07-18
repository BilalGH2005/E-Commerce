import 'package:json_annotation/json_annotation.dart';

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
  final List<SimpleColor> colors;

  @JsonKey(name: "sizes")
  final List<Size> sizes;

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

@JsonSerializable()
class SimpleColor {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "hex_code")
  final String hexCode;

  SimpleColor({required this.id, required this.hexCode});

  factory SimpleColor.fromJson(Map<String, dynamic> json) =>
      _$SimpleColorFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleColorToJson(this);
}

@JsonSerializable()
class Size {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "name")
  final String name;

  Size({required this.id, required this.name});

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
}
