part of 'auth_cubit.dart';

@immutable
sealed class AuthStateCubit {}

final class AuthInitial extends AuthStateCubit {}

final class AuthStateChanged extends AuthStateCubit {}
