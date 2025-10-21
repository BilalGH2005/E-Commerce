// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
  'discount_expiration_date': instance.discountExpirationDate
      ?.toIso8601String(),
};
