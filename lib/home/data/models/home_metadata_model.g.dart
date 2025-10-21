// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeMetadataModel _$HomeMetadataModelFromJson(Map<String, dynamic> json) =>
    HomeMetadataModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestSeller: (json['best_seller'] as List<dynamic>)
          .map((e) => ProductPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
      collections: (json['collections'] as List<dynamic>)
          .map((e) => Collection.fromJson(e as Map<String, dynamic>))
          .toList(),
      newProducts: (json['new_products'] as List<dynamic>)
          .map((e) => ProductPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeMetadataModelToJson(HomeMetadataModel instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'best_seller': instance.bestSeller,
      'collections': instance.collections,
      'new_products': instance.newProducts,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['image_url'] as String,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image_url': instance.imageUrl,
};

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['image_url'] as String,
);

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };
