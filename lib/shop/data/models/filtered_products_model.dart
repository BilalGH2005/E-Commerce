import 'package:e_commerce/core/models/pagination_info.dart';
import 'package:e_commerce/core/models/product_preview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filtered_products_model.g.dart';

@JsonSerializable()
class FilteredProductsModel {
  @JsonKey(name: "products")
  final List<ProductPreview> products;
  @JsonKey(name: "pagination_info")
  final PaginationInfo paginationInfo;

  FilteredProductsModel({required this.products, required this.paginationInfo});

  factory FilteredProductsModel.fromJson(Map<String, dynamic> json) =>
      _$FilteredProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilteredProductsModelToJson(this);
}
