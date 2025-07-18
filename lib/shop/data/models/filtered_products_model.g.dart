// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilteredProductsModel _$FilteredProductsModelFromJson(
        Map<String, dynamic> json) =>
    FilteredProductsModel(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: PaginationInfo.fromJson(
          json['pagination_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilteredProductsModelToJson(
        FilteredProductsModel instance) =>
    <String, dynamic>{
      'products': instance.products,
      'pagination_info': instance.paginationInfo,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      addedAt: DateTime.parse(json['added_at'] as String),
      imagesUrls: (json['images_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      colors: (json['colors'] as List<dynamic>)
          .map((e) => Color.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => Size.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'added_at': instance.addedAt.toIso8601String(),
      'images_urls': instance.imagesUrls,
      'category': instance.category,
      'colors': instance.colors,
      'sizes': instance.sizes,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String,
      name: json['name'] as String,
      discount: (json['discount'] as num?)?.toDouble(),
      discountExpirationDate: json['discount_expiration_date'] == null
          ? null
          : DateTime.parse(json['discount_expiration_date'] as String),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'discount': instance.discount,
      'discount_expiration_date':
          instance.discountExpirationDate?.toIso8601String(),
    };

Color _$ColorFromJson(Map<String, dynamic> json) => Color(
      id: json['id'] as String,
      hexCode: json['hex_code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
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

PaginationInfo _$PaginationInfoFromJson(Map<String, dynamic> json) =>
    PaginationInfo(
      currentPage: (json['current_page'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      isFirstPage: json['is_first_page'] as bool,
      isLastPage: json['is_last_page'] as bool,
    );

Map<String, dynamic> _$PaginationInfoToJson(PaginationInfo instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'page_size': instance.pageSize,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
      'is_first_page': instance.isFirstPage,
      'is_last_page': instance.isLastPage,
    };
