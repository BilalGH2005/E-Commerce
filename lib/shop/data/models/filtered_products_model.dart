import 'package:json_annotation/json_annotation.dart';

part 'filtered_products_model.g.dart';

@JsonSerializable()
class FilteredProductsModel {
  @JsonKey(name: "products")
  final List<Product> products;
  @JsonKey(name: "pagination_info")
  final PaginationInfo paginationInfo;

  FilteredProductsModel({required this.products, required this.paginationInfo});

  factory FilteredProductsModel.fromJson(Map<String, dynamic> json) =>
      _$FilteredProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilteredProductsModelToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "added_at")
  final DateTime addedAt;
  @JsonKey(name: "images_urls")
  final List<String> imagesUrls;
  @JsonKey(name: "category")
  final Category category;
  @JsonKey(name: "colors")
  final List<Color> colors;
  @JsonKey(name: "sizes")
  final List<Size> sizes;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.addedAt,
    required this.imagesUrls,
    required this.category,
    required this.colors,
    required this.sizes,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "discount")
  final double? discount;
  @JsonKey(name: "discount_expiration_date")
  final DateTime? discountExpirationDate;

  Category(
      {required this.id,
      required this.name,
      this.discount,
      this.discountExpirationDate});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Color {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "hex_code")
  final String hexCode;

  Color({required this.id, required this.hexCode, required this.name});

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);

  Map<String, dynamic> toJson() => _$ColorToJson(this);
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

@JsonSerializable()
class PaginationInfo {
  @JsonKey(name: "current_page")
  final int currentPage;
  @JsonKey(name: "page_size")
  final int pageSize;
  @JsonKey(name: "total_items")
  final int totalItems;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "is_first_page")
  final bool isFirstPage;
  @JsonKey(name: "is_last_page")
  final bool isLastPage;

  PaginationInfo(
      {required this.currentPage,
      required this.totalItems,
      required this.pageSize,
      required this.totalPages,
      required this.isFirstPage,
      required this.isLastPage});

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}
