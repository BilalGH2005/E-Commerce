import 'package:supabase_flutter/supabase_flutter.dart';

class EditableProfile {
  final String userId;
  final String email;
  final String displayName;
  final String? avatarUrl;

  const EditableProfile({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.avatarUrl,
  });

  factory EditableProfile.fromUser(User user) {
    final metadata = user.userMetadata ?? const <String, dynamic>{};

    return EditableProfile(
      userId: user.id,
      email: user.email?.trim() ?? '',
      displayName:
          _firstNonEmptyString([
            metadata['display_name'],
            metadata['full_name'],
            metadata['name'],
            user.email?.split('@').first,
          ]) ??
          'Stylish User',
      avatarUrl: _firstNonEmptyString([
        metadata['avatar_url'],
        metadata['picture'],
      ]),
    );
  }

  EditableProfile copyWith({
    String? userId,
    String? email,
    String? displayName,
    String? avatarUrl,
    bool clearAvatarUrl = false,
  }) {
    return EditableProfile(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: clearAvatarUrl ? null : (avatarUrl ?? this.avatarUrl),
    );
  }

  static String? _firstNonEmptyString(Iterable<Object?> candidates) {
    for (final candidate in candidates) {
      final value = (candidate as String?)?.trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }

    return null;
  }
}
