part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminStateChanged extends AdminState {}

final class ImagesStateChanged extends AdminState {}
