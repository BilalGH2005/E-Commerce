import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/settings/presentation/controllers/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAvatarPickerField extends StatelessWidget {
  const ProfileAvatarPickerField({
    super.key,
    required this.onAvatarEditPressed,
  });

  final VoidCallback onAvatarEditPressed;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: cubit.isSaving ? null : onAvatarEditPressed,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: colorScheme(context).tertiary),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme(context).primary.withAlpha(18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: colorScheme(context).primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization(context).chooseAnImage,
                        style: textTheme(
                          context,
                        ).bodySmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cubit.draftAvatarBytes != null
                            ? 'New photo selected. Tap to change it.'
                            : cubit.draftAvatarUrl != null
                            ? 'Take a photo, pick from gallery, or remove the current one.'
                            : 'Take a photo or pick one from your gallery.',
                        style: textTheme(context).displaySmall?.copyWith(
                          color: colorScheme(
                            context,
                          ).inverseSurface.withAlpha(160),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme(context).primary,
                ),
              ],
            ),
          ),
        ),
        if (cubit.hasAvatarDraft) ...[
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: cubit.isSaving
                  ? null
                  : () => cubit.setAvatarDraft(null),
              icon: const Icon(Icons.delete_outline_rounded),
              label: Text(localization(context).removePicture),
            ),
          ),
        ],
        const SizedBox(height: 6),
        Text(
          'Your selected image will be uploaded when you save the profile.',
          style: textTheme(context).displaySmall?.copyWith(
            color: colorScheme(context).inverseSurface.withAlpha(150),
          ),
        ),
      ],
    );
  }
}
