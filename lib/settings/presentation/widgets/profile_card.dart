import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'profile_avatar.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    final name = profileDisplayName(user);
    final email = user?.email?.trim();
    final avatarUrl = profileAvatarUrl(user);

    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme(context).primary.withAlpha(230),
            colorScheme(context).primaryFixed.withAlpha(210),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme(context).primary.withAlpha(55),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          ProfileAvatar(
            size: 72,
            name: name,
            avatarUrl: avatarUrl,
            backgroundColor: Colors.white.withAlpha(35),
            borderColor: Colors.white.withAlpha(70),
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            fallbackPadding: const EdgeInsets.all(8),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme(context).bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (email != null && email.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme(context).displaySmall?.copyWith(
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
