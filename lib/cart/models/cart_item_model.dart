import 'package:e_commerce/core/models/json_size.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItem {
  final int quantity;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  @JsonKey(name: 'new_price')
  final double newPrice;

  @JsonKey(name: 'old_price')
  final double oldPrice;

  @JsonKey(name: 'product_id')
  final String productId;

  @JsonKey(name: 'picked_size')
  final JsonSize pickedSize;

  @JsonKey(name: 'picked_color')
  final SimpleJsonColor pickedColor;

  @JsonKey(name: 'product_name')
  final String productName;

  CartItem({
    required this.quantity,
    required this.imageUrl,
    required this.newPrice,
    required this.oldPrice,
    required this.productId,
    required this.pickedSize,
    required this.pickedColor,
    required this.productName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  CartItem copyWith({
    int? quantity,
    String? imageUrl,
    double? newPrice,
    double? oldPrice,
    String? productId,
    JsonSize? pickedSize,
    SimpleJsonColor? pickedColor,
    String? productName,
  }) {
    return CartItem(
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      newPrice: newPrice ?? this.newPrice,
      oldPrice: oldPrice ?? this.oldPrice,
      productId: productId ?? this.productId,
      pickedSize: pickedSize ?? this.pickedSize,
      pickedColor: pickedColor ?? this.pickedColor,
      productName: productName ?? this.productName,
    );
  }
}

@JsonSerializable()
class SimpleJsonColor {
  final String id;
  final String name;

  SimpleJsonColor({required this.id, required this.name});

  factory SimpleJsonColor.fromJson(Map<String, dynamic> json) =>
      _$SimpleJsonColorFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleJsonColorToJson(this);
}
