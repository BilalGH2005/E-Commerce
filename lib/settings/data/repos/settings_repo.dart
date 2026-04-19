import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/auth_failure_mapper.dart';
import '../../models/editable_profile.dart';

abstract class SettingsRepo {
  Future<AsyncResult<void, String>> deleteUser({required String userId});

  Future<AsyncResult<String, String>> uploadProfileImage({
    required String userId,
    required Uint8List bytes,
    required String fileExtension,
  });

  Future<AsyncResult<EditableProfile, String>> updateProfile({
    required String displayName,
    String? avatarUrl,
  });
}

class SupabaseSettingsRepo implements SettingsRepo {
  final _supabaseAuth = Supabase.instance.client.auth;
  final _supabaseStorage = Supabase.instance.client.storage;

  static const _profileImagesBucket = 'users_profile_image';

  @override
  Future<AsyncResult<void, String>> deleteUser({required String userId}) {
    return supabaseRpc('delete_user', params: {'user_id': userId});
  }

  @override
  Future<AsyncResult<String, String>> uploadProfileImage({
    required String userId,
    required Uint8List bytes,
    required String fileExtension,
  }) async {
    try {
      final normalizedExtension = _normalizedFileExtension(fileExtension);
      final storagePath = '$userId/profile_image';

      await _supabaseStorage.from(_profileImagesBucket).uploadBinary(
        storagePath,
        bytes,
        fileOptions: FileOptions(
          upsert: true,
          contentType: _contentTypeForExtension(normalizedExtension),
        ),
      );

      final publicUrl = _supabaseStorage
          .from(_profileImagesBucket)
          .getPublicUrl(storagePath);

      return AsyncResult.data(
        data: '$publicUrl?v=${DateTime.now().millisecondsSinceEpoch}',
      );
    } on StorageException catch (_) {
      return AsyncResult.error(error: 'other');
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }

  @override
  Future<AsyncResult<EditableProfile, String>> updateProfile({
    required String displayName,
    String? avatarUrl,
  }) async {
    try {
      // this method is not accessible unless user is logged in => current user can't be null
      final currentUser = _supabaseAuth.currentUser!;

      final userMetadata = Map<String, dynamic>.from(
        currentUser.userMetadata ?? const <String, dynamic>{},
      );

      userMetadata['display_name'] = displayName.trim();
      if (avatarUrl == null || avatarUrl.trim().isEmpty) {
        userMetadata.remove('avatar_url');
      } else {
        userMetadata['avatar_url'] = avatarUrl.trim();
      }

      final response = await _supabaseAuth.updateUser(
        UserAttributes(data: userMetadata),
      );

      return AsyncResult.data(data: EditableProfile.fromUser(response.user!));
    } on AuthException catch (exception) {
      return AsyncResult.error(
        error: AuthFailureMapper.supabaseAuthError(exception.code),
      );
    } on SocketException catch (_) {
      return AsyncResult.error(error: 'noInternetConnection');
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }
}

String _normalizedFileExtension(String fileExtension) {
  final normalized = fileExtension.trim().replaceFirst('.', '').toLowerCase();
  if (normalized.isEmpty) {
    return 'jpg';
  }

  return normalized;
}

String _contentTypeForExtension(String fileExtension) {
  switch (fileExtension) {
    case 'png':
      return 'image/png';
    case 'webp':
      return 'image/webp';
    case 'gif':
      return 'image/gif';
    case 'heic':
      return 'image/heic';
    default:
      return 'image/jpeg';
  }
}
