part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadingStartedState extends CartState {}

final class CartFailedState extends CartState {}

final class CartItemsFetchedSuccessfullyState extends CartState {}

final class CartFetchFailedState extends CartState {}

final class CartStateChanged extends CartState {}

final class CartCouponDoesNotExistState extends CartState {}

final class CartCouponAppliedState extends CartState {}
