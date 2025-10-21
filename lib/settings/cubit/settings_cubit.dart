import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/data/repos/auth_repo.dart';
import '../../core/utils/dependency_injection.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  bool isLoading = false;

  Future<void> signOut() async {
    isLoading = true;
    emit(SettingsLoading());

    final result = await serviceLocator<AuthRepo>().signOut();

    isLoading = false;

    if (result.isData) {
      emit(SettingsSignOutSuccess());
    } else {
      emit(SettingsSignOutFailure(errorCode: result.error!));
    }
  }
}
