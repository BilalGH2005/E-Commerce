part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsStateChanged extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class AccountIsDeletedSuccessfully extends SettingsState {}

final class AccountDeletionIsFailed extends SettingsState {}

final class SettingsSignOutSuccess extends SettingsState {}

final class SettingsSignOutFailure extends SettingsState {
  final String errorCode;

  SettingsSignOutFailure({required this.errorCode});
}

final class SettingsFormChanged extends SettingsState {}

final class SettingsSaveSuccess extends SettingsState {}

final class SettingsSaveFailure extends SettingsState {
  final String errorCode;

  SettingsSaveFailure({required this.errorCode});
}
