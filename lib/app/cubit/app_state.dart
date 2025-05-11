part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppThemeChanged extends AppState {}

final class AppLocaleChanged extends AppState {}

final class GotAppInitialData extends AppState {}
