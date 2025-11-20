// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductFilters {

 String? get categoryId; String? get searchQuery; String? get colorId; String? get sizeId; int get page; RangeValues? get priceRange;
/// Create a copy of ProductFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFiltersCopyWith<ProductFilters> get copyWith => _$ProductFiltersCopyWithImpl<ProductFilters>(this as ProductFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFilters&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.colorId, colorId) || other.colorId == colorId)&&(identical(other.sizeId, sizeId) || other.sizeId == sizeId)&&(identical(other.page, page) || other.page == page)&&(identical(other.priceRange, priceRange) || other.priceRange == priceRange));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,searchQuery,colorId,sizeId,page,priceRange);

@override
String toString() {
  return 'ProductFilters(categoryId: $categoryId, searchQuery: $searchQuery, colorId: $colorId, sizeId: $sizeId, page: $page, priceRange: $priceRange)';
}


}

/// @nodoc
abstract mixin class $ProductFiltersCopyWith<$Res>  {
  factory $ProductFiltersCopyWith(ProductFilters value, $Res Function(ProductFilters) _then) = _$ProductFiltersCopyWithImpl;
@useResult
$Res call({
 String? categoryId, String? searchQuery, String? colorId, String? sizeId, int page, RangeValues? priceRange
});




}
/// @nodoc
class _$ProductFiltersCopyWithImpl<$Res>
    implements $ProductFiltersCopyWith<$Res> {
  _$ProductFiltersCopyWithImpl(this._self, this._then);

  final ProductFilters _self;
  final $Res Function(ProductFilters) _then;

/// Create a copy of ProductFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = freezed,Object? searchQuery = freezed,Object? colorId = freezed,Object? sizeId = freezed,Object? page = null,Object? priceRange = freezed,}) {
  return _then(_self.copyWith(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,colorId: freezed == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as String?,sizeId: freezed == sizeId ? _self.sizeId : sizeId // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,priceRange: freezed == priceRange ? _self.priceRange : priceRange // ignore: cast_nullable_to_non_nullable
as RangeValues?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductFilters].
extension ProductFiltersPatterns on ProductFilters {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductFilters() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductFilters value)  $default,){
final _that = this;
switch (_that) {
case _ProductFilters():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductFilters value)?  $default,){
final _that = this;
switch (_that) {
case _ProductFilters() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? categoryId,  String? searchQuery,  String? colorId,  String? sizeId,  int page,  RangeValues? priceRange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductFilters() when $default != null:
return $default(_that.categoryId,_that.searchQuery,_that.colorId,_that.sizeId,_that.page,_that.priceRange);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? categoryId,  String? searchQuery,  String? colorId,  String? sizeId,  int page,  RangeValues? priceRange)  $default,) {final _that = this;
switch (_that) {
case _ProductFilters():
return $default(_that.categoryId,_that.searchQuery,_that.colorId,_that.sizeId,_that.page,_that.priceRange);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? categoryId,  String? searchQuery,  String? colorId,  String? sizeId,  int page,  RangeValues? priceRange)?  $default,) {final _that = this;
switch (_that) {
case _ProductFilters() when $default != null:
return $default(_that.categoryId,_that.searchQuery,_that.colorId,_that.sizeId,_that.page,_that.priceRange);case _:
  return null;

}
}

}

/// @nodoc


class _ProductFilters implements ProductFilters {
  const _ProductFilters({this.categoryId, this.searchQuery, this.colorId, this.sizeId, this.page = 1, this.priceRange});
  

@override final  String? categoryId;
@override final  String? searchQuery;
@override final  String? colorId;
@override final  String? sizeId;
@override@JsonKey() final  int page;
@override final  RangeValues? priceRange;

/// Create a copy of ProductFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductFiltersCopyWith<_ProductFilters> get copyWith => __$ProductFiltersCopyWithImpl<_ProductFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductFilters&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.colorId, colorId) || other.colorId == colorId)&&(identical(other.sizeId, sizeId) || other.sizeId == sizeId)&&(identical(other.page, page) || other.page == page)&&(identical(other.priceRange, priceRange) || other.priceRange == priceRange));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,searchQuery,colorId,sizeId,page,priceRange);

@override
String toString() {
  return 'ProductFilters(categoryId: $categoryId, searchQuery: $searchQuery, colorId: $colorId, sizeId: $sizeId, page: $page, priceRange: $priceRange)';
}


}

/// @nodoc
abstract mixin class _$ProductFiltersCopyWith<$Res> implements $ProductFiltersCopyWith<$Res> {
  factory _$ProductFiltersCopyWith(_ProductFilters value, $Res Function(_ProductFilters) _then) = __$ProductFiltersCopyWithImpl;
@override @useResult
$Res call({
 String? categoryId, String? searchQuery, String? colorId, String? sizeId, int page, RangeValues? priceRange
});




}
/// @nodoc
class __$ProductFiltersCopyWithImpl<$Res>
    implements _$ProductFiltersCopyWith<$Res> {
  __$ProductFiltersCopyWithImpl(this._self, this._then);

  final _ProductFilters _self;
  final $Res Function(_ProductFilters) _then;

/// Create a copy of ProductFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = freezed,Object? searchQuery = freezed,Object? colorId = freezed,Object? sizeId = freezed,Object? page = null,Object? priceRange = freezed,}) {
  return _then(_ProductFilters(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,colorId: freezed == colorId ? _self.colorId : colorId // ignore: cast_nullable_to_non_nullable
as String?,sizeId: freezed == sizeId ? _self.sizeId : sizeId // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,priceRange: freezed == priceRange ? _self.priceRange : priceRange // ignore: cast_nullable_to_non_nullable
as RangeValues?,
  ));
}


}

// dart format on
