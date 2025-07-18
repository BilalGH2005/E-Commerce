import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filters.freezed.dart';

@freezed
class ProductFilters with _$ProductFilters {
  const factory ProductFilters({
    String? categoryId,
    String? searchQuery,
    String? colorId,
    String? sizeId,
    @Default(1) int page,
    RangeValues? priceRange,
  }) = _ProductFilters;

  factory ProductFilters.empty() => const ProductFilters();
}
