part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsSignOutSuccess extends SettingsState {}

final class SettingsSignOutFailure extends SettingsState {
  final String errorCode;

  SettingsSignOutFailure({required this.errorCode});
}
