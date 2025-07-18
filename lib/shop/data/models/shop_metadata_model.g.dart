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
          .map((e) => SimpleColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => Size.fromJson(e as Map<String, dynamic>))
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
    SimpleCategory(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SimpleCategoryToJson(SimpleCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SimpleColor _$SimpleColorFromJson(Map<String, dynamic> json) => SimpleColor(
      id: json['id'] as String,
      hexCode: json['hex_code'] as String,
    );

Map<String, dynamic> _$SimpleColorToJson(SimpleColor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hex_code': instance.hexCode,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
