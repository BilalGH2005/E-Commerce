// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductFilters {
  String? get categoryId => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  String? get colorId => throw _privateConstructorUsedError;
  String? get sizeId => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  RangeValues? get priceRange => throw _privateConstructorUsedError;

  /// Create a copy of ProductFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductFiltersCopyWith<ProductFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductFiltersCopyWith<$Res> {
  factory $ProductFiltersCopyWith(
          ProductFilters value, $Res Function(ProductFilters) then) =
      _$ProductFiltersCopyWithImpl<$Res, ProductFilters>;
  @useResult
  $Res call(
      {String? categoryId,
      String? searchQuery,
      String? colorId,
      String? sizeId,
      int page,
      RangeValues? priceRange});
}

/// @nodoc
class _$ProductFiltersCopyWithImpl<$Res, $Val extends ProductFilters>
    implements $ProductFiltersCopyWith<$Res> {
  _$ProductFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? searchQuery = freezed,
    Object? colorId = freezed,
    Object? sizeId = freezed,
    Object? page = null,
    Object? priceRange = freezed,
  }) {
    return _then(_value.copyWith(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      colorId: freezed == colorId
          ? _value.colorId
          : colorId // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeId: freezed == sizeId
          ? _value.sizeId
          : sizeId // ignore: cast_nullable_to_non_nullable
              as String?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      priceRange: freezed == priceRange
          ? _value.priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as RangeValues?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductFiltersImplCopyWith<$Res>
    implements $ProductFiltersCopyWith<$Res> {
  factory _$$ProductFiltersImplCopyWith(_$ProductFiltersImpl value,
          $Res Function(_$ProductFiltersImpl) then) =
      __$$ProductFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? categoryId,
      String? searchQuery,
      String? colorId,
      String? sizeId,
      int page,
      RangeValues? priceRange});
}

/// @nodoc
class __$$ProductFiltersImplCopyWithImpl<$Res>
    extends _$ProductFiltersCopyWithImpl<$Res, _$ProductFiltersImpl>
    implements _$$ProductFiltersImplCopyWith<$Res> {
  __$$ProductFiltersImplCopyWithImpl(
      _$ProductFiltersImpl _value, $Res Function(_$ProductFiltersImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? searchQuery = freezed,
    Object? colorId = freezed,
    Object? sizeId = freezed,
    Object? page = null,
    Object? priceRange = freezed,
  }) {
    return _then(_$ProductFiltersImpl(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      colorId: freezed == colorId
          ? _value.colorId
          : colorId // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeId: freezed == sizeId
          ? _value.sizeId
          : sizeId // ignore: cast_nullable_to_non_nullable
              as String?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      priceRange: freezed == priceRange
          ? _value.priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as RangeValues?,
    ));
  }
}

/// @nodoc

class _$ProductFiltersImpl implements _ProductFilters {
  const _$ProductFiltersImpl(
      {this.categoryId,
      this.searchQuery,
      this.colorId,
      this.sizeId,
      this.page = 1,
      this.priceRange});

  @override
  final String? categoryId;
  @override
  final String? searchQuery;
  @override
  final String? colorId;
  @override
  final String? sizeId;
  @override
  @JsonKey()
  final int page;
  @override
  final RangeValues? priceRange;

  @override
  String toString() {
    return 'ProductFilters(categoryId: $categoryId, searchQuery: $searchQuery, colorId: $colorId, sizeId: $sizeId, page: $page, priceRange: $priceRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductFiltersImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.colorId, colorId) || other.colorId == colorId) &&
            (identical(other.sizeId, sizeId) || other.sizeId == sizeId) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, categoryId, searchQuery, colorId, sizeId, page, priceRange);

  /// Create a copy of ProductFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductFiltersImplCopyWith<_$ProductFiltersImpl> get copyWith =>
      __$$ProductFiltersImplCopyWithImpl<_$ProductFiltersImpl>(
          this, _$identity);
}

abstract class _ProductFilters implements ProductFilters {
  const factory _ProductFilters(
      {final String? categoryId,
      final String? searchQuery,
      final String? colorId,
      final String? sizeId,
      final int page,
      final RangeValues? priceRange}) = _$ProductFiltersImpl;

  @override
  String? get categoryId;
  @override
  String? get searchQuery;
  @override
  String? get colorId;
  @override
  String? get sizeId;
  @override
  int get page;
  @override
  RangeValues? get priceRange;

  /// Create a copy of ProductFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductFiltersImplCopyWith<_$ProductFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
