// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPreview _$ProductPreviewFromJson(Map<String, dynamic> json) =>
    ProductPreview(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      finalPrice: (json['final_price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$ProductPreviewToJson(ProductPreview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'final_price': instance.finalPrice,
      'image_url': instance.imageUrl,
    };
