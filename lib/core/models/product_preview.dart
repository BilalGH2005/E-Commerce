import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_preview.g.dart';

@JsonSerializable()
class ProductPreview {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'final_price')
  final double finalPrice;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  ProductPreview({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.finalPrice,
    required this.imageUrl,
  });

  factory ProductPreview.fromJson(Map<String, dynamic> json) =>
      _$ProductPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPreviewToJson(this);
}
