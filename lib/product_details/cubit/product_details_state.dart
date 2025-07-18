part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductInitial extends ProductDetailsState {}

final class ProductDetailsDataChangedState extends ProductDetailsState {}
