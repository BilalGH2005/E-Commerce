part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopStateChanged extends ShopState {}

final class ShopLoadingMoreFailed extends ShopState {}
