// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      finalPrice: (json['final_price'] as num).toDouble(),
      addedAt: DateTime.parse(json['added_at'] as String),
      imagesUrls: (json['images_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      colors: (json['colors'] as List<dynamic>)
          .map((e) => JsonColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => JsonSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      similarProducts: (json['similar_products'] as List<dynamic>)
          .map((e) => ProductPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
  ProductDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'final_price': instance.finalPrice,
  'added_at': instance.addedAt.toIso8601String(),
  'images_urls': instance.imagesUrls,
  'category': instance.category,
  'colors': instance.colors,
  'sizes': instance.sizes,
  'similar_products': instance.similarProducts,
};
