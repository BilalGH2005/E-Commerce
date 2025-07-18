part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeGetProductFailed extends HomeState {}

final class HomeGetProductSuccess extends HomeState {}
