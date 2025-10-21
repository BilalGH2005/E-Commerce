import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.g.dart';

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

  Category({
    required this.id,
    required this.name,
    this.discount,
    this.discountExpirationDate,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
