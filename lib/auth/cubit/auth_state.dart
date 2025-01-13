part of 'auth_cubit.dart';

sealed class AuthCubitState {}

final class AuthInitial extends AuthCubitState {}

final class AuthStateChanged extends AuthCubitState {}
