part of 'login_callback_cubit.dart';

sealed class LoginCallbackState {}

final class LoginCallbackInitial extends LoginCallbackState {}

final class LoginSuccessState extends LoginCallbackState {}
