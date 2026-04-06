part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFormChanged extends AuthState {}

final class AuthResetPasswordRequested extends AuthState {}

final class AuthShowChangePasswordDialog extends AuthState {}

final class AuthFailure extends AuthState {
  final String errorCode;

  AuthFailure({required this.errorCode});
}

final class AuthResetPasswordSuccess extends AuthState {}

final class AuthSuccessSignIn extends AuthState {}

final class AuthSuccessSignUp extends AuthState {}
