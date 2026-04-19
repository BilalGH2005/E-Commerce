import 'dart:typed_data';

import 'package:e_commerce/settings/presentation/widgets/delete_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../auth/data/repos/auth_repo.dart';
import '../../../core/utils/dependency_injection.dart';
import '../../data/repos/settings_repo.dart';
import '../../models/editable_profile.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo _settingsRepo;

  SettingsCubit(SettingsRepo settingsRepo)
    : _settingsRepo = settingsRepo,
      super(SettingsInitial());

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final avatarUrlController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  AsyncValue<EditableProfile, String> profile = AsyncValue.initial();
  bool isSaving = false;
  Uint8List? draftAvatarBytes;
  String? draftAvatarExtension;

  String? get draftAvatarUrl {
    final value = avatarUrlController.text.trim();
    return value.isEmpty ? null : value;
  }

  bool get hasAvatarDraft => draftAvatarBytes != null || draftAvatarUrl != null;

  void hydrateProfileFromCurrentUser() {
    final currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser == null) {
      resetProfileDraft();
      return;
    }

    final profileData = EditableProfile.fromUser(currentUser);
    _populateControllers(profileData);
    profile = AsyncValue.data(data: profileData);
    emit(SettingsStateChanged());
  }

  void onFormChanged() {
    emit(SettingsStateChanged());
  }

  Future<String?> pickAvatarFromCamera() async {
    return _pickAvatarImage(ImageSource.camera);
  }

  Future<String?> pickAvatarFromGallery() async {
    return _pickAvatarImage(ImageSource.gallery);
  }

  Future<String?> _pickAvatarImage(ImageSource source) async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: source,
        imageQuality: 86,
        maxWidth: 1600,
      );

      if (pickedImage == null) {
        return null;
      }

      draftAvatarBytes = await pickedImage.readAsBytes();
      draftAvatarExtension = _fileExtensionFromPath(
        pickedImage.name.isEmpty ? pickedImage.path : pickedImage.name,
      );
      emit(SettingsStateChanged());
      return null;
    } catch (_) {
      return 'other';
    }
  }

  void setAvatarDraft(String? avatarUrl) {
    draftAvatarBytes = null;
    draftAvatarExtension = null;
    avatarUrlController.text = avatarUrl?.trim() ?? '';
    onFormChanged();
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    isSaving = true;
    emit(SettingsStateChanged());

    final currentUserId =
        profile.data?.userId ?? Supabase.instance.client.auth.currentUser?.id;

    if (currentUserId == null) {
      isSaving = false;
      emit(SettingsSaveFailure(errorCode: 'other'));
      return;
    }

    var avatarUrl = draftAvatarUrl;
    if (draftAvatarBytes != null) {
      final uploadResult = await _settingsRepo.uploadProfileImage(
        userId: currentUserId,
        bytes: draftAvatarBytes!,
        fileExtension: draftAvatarExtension ?? 'jpg',
      );

      if (!uploadResult.isData) {
        isSaving = false;
        emit(SettingsSaveFailure(errorCode: uploadResult.error!));
        return;
      }

      avatarUrl = uploadResult.data!;
    }

    final result = await _settingsRepo.updateProfile(
      displayName: nameController.text.trim(),
      avatarUrl: avatarUrl,
    );

    isSaving = false;

    if (result.isData) {
      final profileData = result.data!;
      _populateControllers(profileData);
      profile = AsyncValue.data(data: profileData);
      emit(SettingsSaveSuccess());
    } else {
      emit(SettingsSaveFailure(errorCode: result.error!));
    }
  }

  void _populateControllers(EditableProfile profileData) {
    nameController.text = profileData.displayName;
    avatarUrlController.text = profileData.avatarUrl ?? '';
    draftAvatarBytes = null;
    draftAvatarExtension = null;
  }

  void resetProfileDraft({bool notify = true}) {
    nameController.clear();
    avatarUrlController.clear();
    draftAvatarBytes = null;
    draftAvatarExtension = null;
    profile = AsyncValue.initial();
    if (notify) {
      emit(SettingsStateChanged());
    }
  }

  Future<void> deleteUser({required String userId}) async {
    isLoading = true;
    emit(SettingsLoading());
    await serviceLocator<AuthRepo>().signOut();
    resetProfileDraft(notify: false);
    final result = await _settingsRepo.deleteUser(userId: userId);
    if (result.isData) {
      emit(AccountIsDeletedSuccessfully());
    } else {
      emit(AccountDeletionIsFailed());
    }
    isLoading = false;
    emit(SettingsLoading());
  }

  Future<void> signOut() async {
    isLoading = true;
    emit(AccountIsDeletedSuccessfully());

    final result = await serviceLocator<AuthRepo>().signOut();
    isLoading = false;

    if (result.isData) {
      resetProfileDraft(notify: false);
      emit(SettingsSignOutSuccess());
    } else {
      emit(SettingsSignOutFailure(errorCode: result.error!));
    }
  }

  Future<bool?> showDeleteAccountDialog({
    required BuildContext context,
    required String userId,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: this,
          child: DeleteAccountDialog(userId: userId),
        );
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    avatarUrlController.dispose();
    return super.close();
  }
}

String _fileExtensionFromPath(String path) {
  final dotIndex = path.lastIndexOf('.');
  if (dotIndex == -1 || dotIndex == path.length - 1) {
    return 'jpg';
  }

  return path.substring(dotIndex + 1).toLowerCase();
}
