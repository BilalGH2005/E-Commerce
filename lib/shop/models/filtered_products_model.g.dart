// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilteredProductsModel _$FilteredProductsModelFromJson(
  Map<String, dynamic> json,
) => FilteredProductsModel(
  products: (json['products'] as List<dynamic>)
      .map((e) => ProductPreview.fromJson(e as Map<String, dynamic>))
      .toList(),
  paginationInfo: PaginationInfo.fromJson(
    json['pagination_info'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$FilteredProductsModelToJson(
  FilteredProductsModel instance,
) => <String, dynamic>{
  'products': instance.products,
  'pagination_info': instance.paginationInfo,
};
