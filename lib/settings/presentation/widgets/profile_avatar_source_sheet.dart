import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';

enum ProfileAvatarSourceAction { camera, gallery, remove }

class ProfileAvatarSourceSheet extends StatelessWidget {
  const ProfileAvatarSourceSheet({super.key, required this.hasAvatar});

  final bool hasAvatar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: Text(
              localization(context).takePicture,
              style: textTheme(context).displayMedium,
            ),
            onTap: () {
              Navigator.of(context).pop(ProfileAvatarSourceAction.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(
              localization(context).chooseFromGallery,
              style: textTheme(context).displayMedium,
            ),
            onTap: () {
              Navigator.of(context).pop(ProfileAvatarSourceAction.gallery);
            },
          ),
          if (hasAvatar)
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded),
              title: Text(
                localization(context).removePicture,
                style: textTheme(context).displayMedium,
              ),
              onTap: () {
                Navigator.of(context).pop(ProfileAvatarSourceAction.remove);
              },
            ),
          ListTile(
            leading: const Icon(Icons.close_rounded),
            title: Text(
              localization(context).cancel,
              style: textTheme(context).displayMedium,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
