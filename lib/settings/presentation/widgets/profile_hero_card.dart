import 'dart:typed_data';

import 'package:e_commerce/core/constants/assets.gen.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/settings/models/editable_profile.dart';
import 'package:e_commerce/settings/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({
    super.key,
    required this.profileData,
    required this.previewName,
    required this.previewAvatarUrl,
    required this.previewAvatarBytes,
    required this.onAvatarEditPressed,
  });

  final EditableProfile profileData;
  final String previewName;
  final String? previewAvatarUrl;
  final Uint8List? previewAvatarBytes;
  final VoidCallback onAvatarEditPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme(context).primary.withAlpha(228),
            colorScheme(context).primaryFixed.withAlpha(210),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme(context).primary.withAlpha(50),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              ProfileAvatar(
                size: 128,
                name: previewName,
                avatarUrl: previewAvatarUrl,
                imageBytes: previewAvatarBytes,
                backgroundColor: Colors.white.withAlpha(26),
                borderColor: Colors.white.withAlpha(78),
                foregroundColor: Colors.white,
                shadowColor: Colors.black.withAlpha(28),
                fallbackPadding: const EdgeInsets.all(16),
                borderWidth: 2,
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Material(
                  color: colorScheme(context).surface,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onAvatarEditPressed,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        Assets.icons.pencil,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          colorScheme(context).primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            previewName,
            textAlign: TextAlign.center,
            style: textTheme(context).bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (profileData.email.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              profileData.email,
              textAlign: TextAlign.center,
              style: textTheme(
                context,
              ).displaySmall?.copyWith(color: Colors.white.withAlpha(220)),
            ),
          ],
        ],
      ),
    );
  }
}
