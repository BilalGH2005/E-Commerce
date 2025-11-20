class OrderDetails {
  final String productId;
  final String colorId;
  final String sizeId;

  OrderDetails({
    required this.productId,
    required this.colorId,
    required this.sizeId,
  });

  OrderDetails copyWith({String? productId, String? colorId, String? sizeId}) {
    return OrderDetails(
      productId: productId ?? this.productId,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetails &&
        other.productId == productId &&
        other.colorId == colorId &&
        other.sizeId == sizeId;
  }

  @override
  int get hashCode => colorId.hashCode ^ sizeId.hashCode ^ productId.hashCode;
}
