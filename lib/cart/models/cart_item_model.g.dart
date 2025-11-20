// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  quantity: (json['quantity'] as num).toInt(),
  imageUrl: json['image_url'] as String,
  newPrice: (json['new_price'] as num).toDouble(),
  oldPrice: (json['old_price'] as num).toDouble(),
  productId: json['product_id'] as String,
  pickedSize: JsonSize.fromJson(json['picked_size'] as Map<String, dynamic>),
  pickedColor: SimpleJsonColor.fromJson(
    json['picked_color'] as Map<String, dynamic>,
  ),
  productName: json['product_name'] as String,
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'quantity': instance.quantity,
  'image_url': instance.imageUrl,
  'new_price': instance.newPrice,
  'old_price': instance.oldPrice,
  'product_id': instance.productId,
  'picked_size': instance.pickedSize,
  'picked_color': instance.pickedColor,
  'product_name': instance.productName,
};

SimpleJsonColor _$SimpleJsonColorFromJson(Map<String, dynamic> json) =>
    SimpleJsonColor(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$SimpleJsonColorToJson(SimpleJsonColor instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
