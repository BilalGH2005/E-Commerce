import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String profileDisplayName(User? user) {
  final metadata = user?.userMetadata ?? const <String, dynamic>{};
  final candidates = [
    metadata['display_name'],
    metadata['full_name'],
    metadata['name'],
  ];

  for (final candidate in candidates) {
    final value = (candidate as String?)?.trim();
    if (value != null && value.isNotEmpty) {
      return value;
    }
  }

  final emailPrefix = user?.email?.split('@').first.trim();
  if (emailPrefix != null && emailPrefix.isNotEmpty) {
    return emailPrefix;
  }

  return 'Stylish User';
}

String? profileAvatarUrl(User? user) {
  final metadata = user?.userMetadata ?? const <String, dynamic>{};
  final candidates = [metadata['avatar_url'], metadata['picture']];

  for (final candidate in candidates) {
    final value = (candidate as String?)?.trim();
    if (value != null && value.isNotEmpty) {
      return value;
    }
  }

  return null;
}

String profileInitials(String name) {
  final parts = name
      .split(RegExp(r'\s+'))
      .where((part) => part.trim().isNotEmpty)
      .toList();

  if (parts.isEmpty) return 'S';
  if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();

  return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
      .toUpperCase();
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.name,
    this.avatarUrl,
    this.imageBytes,
    this.size = 72,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
    this.shadowColor,
    this.fallbackPadding,
    this.borderWidth = 1,
  });

  final String name;
  final String? avatarUrl;
  final Uint8List? imageBytes;
  final double size;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? fallbackPadding;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedBackgroundColor =
        backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final resolvedForegroundColor =
        foregroundColor ?? theme.colorScheme.primary;
    final resolvedShadowColor =
        shadowColor ?? theme.colorScheme.shadow.withAlpha(24);
    final resolvedFallbackPadding =
        fallbackPadding ?? EdgeInsets.all(size * 0.18);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: resolvedBackgroundColor,
        border: borderColor == null
            ? null
            : Border.all(color: borderColor!, width: borderWidth),
        boxShadow: resolvedShadowColor.alpha == 0
            ? null
            : [
                BoxShadow(
                  color: resolvedShadowColor,
                  blurRadius: size * 0.26,
                  offset: Offset(0, size * 0.1),
                ),
              ],
      ),
      child: ClipOval(
        child: imageBytes != null
            ? Image.memory(
                imageBytes!,
                fit: BoxFit.cover,
                width: size,
                height: size,
              )
            : avatarUrl == null
            ? Padding(
                padding: resolvedFallbackPadding,
                child: _AvatarFallback(
                  name: name,
                  foregroundColor: resolvedForegroundColor,
                ),
              )
            : CachedNetworkImage(
                imageUrl: avatarUrl!,
                fit: BoxFit.cover,
                width: size,
                height: size,
                placeholder: (_, _) => Container(
                  color: resolvedBackgroundColor,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: size * 0.22,
                    height: size * 0.22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: resolvedForegroundColor,
                    ),
                  ),
                ),
                errorWidget: (_, _, _) => Padding(
                  padding: resolvedFallbackPadding,
                  child: _AvatarFallback(
                    name: name,
                    foregroundColor: resolvedForegroundColor,
                  ),
                ),
              ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.name, required this.foregroundColor});

  final String name;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        profileInitials(name),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
