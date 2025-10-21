class OrderDetails {
  final String colorId;
  final String sizeId;

  OrderDetails({
    required this.colorId,
    required this.sizeId,
  });

  OrderDetails copyWith({
    String? colorId,
    String? sizeId,
  }) {
    return OrderDetails(
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetails &&
        other.colorId == colorId &&
        other.sizeId == sizeId;
  }

  @override
  int get hashCode => colorId.hashCode ^ sizeId.hashCode;
}
