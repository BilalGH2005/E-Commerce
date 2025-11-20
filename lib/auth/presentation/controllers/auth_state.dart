part of 'auth_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthInitial extends AuthCubitState {}

final class AuthLoading extends AuthCubitState {}

final class AuthFormChanged extends AuthCubitState {}

final class AuthResetPasswordRequested extends AuthCubitState {}

final class AuthFailure extends AuthCubitState {
  final String errorCode;

  AuthFailure({required this.errorCode});
}

final class AuthResetPasswordSuccess extends AuthCubitState {}

final class AuthSuccessSignIn extends AuthCubitState {}

final class AuthSuccessSignUp extends AuthCubitState {}
