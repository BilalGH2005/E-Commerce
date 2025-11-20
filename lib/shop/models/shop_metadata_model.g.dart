// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopMetadata _$ShopMetadataFromJson(Map<String, dynamic> json) => ShopMetadata(
  minPrice: (json['min_price'] as num).toDouble(),
  maxPrice: (json['max_price'] as num).toDouble(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => SimpleCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
  colors: (json['colors'] as List<dynamic>)
      .map((e) => JsonColor.fromJson(e as Map<String, dynamic>))
      .toList(),
  sizes: (json['sizes'] as List<dynamic>)
      .map((e) => JsonSize.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ShopMetadataToJson(ShopMetadata instance) =>
    <String, dynamic>{
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'categories': instance.categories,
      'colors': instance.colors,
      'sizes': instance.sizes,
    };

SimpleCategory _$SimpleCategoryFromJson(Map<String, dynamic> json) =>
    SimpleCategory(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$SimpleCategoryToJson(SimpleCategory instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
