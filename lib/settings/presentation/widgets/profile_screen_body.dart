import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/constants/assets.gen.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:e_commerce/settings/models/editable_profile.dart';
import 'package:e_commerce/settings/presentation/controllers/settings_cubit.dart';
import 'package:e_commerce/settings/presentation/widgets/profile_avatar_picker_field.dart';
import 'package:e_commerce/settings/presentation/widgets/profile_hero_card.dart';
import 'package:e_commerce/settings/presentation/widgets/settings_opaque_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    super.key,
    required this.profileData,
    required this.onAvatarEditPressed,
  });

  final EditableProfile profileData;
  final VoidCallback onAvatarEditPressed;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final previewName = cubit.nameController.text.trim().isEmpty
        ? profileData.displayName
        : cubit.nameController.text.trim();
    final previewAvatarUrl = cubit.draftAvatarUrl;
    final previewAvatarBytes = cubit.draftAvatarBytes;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppBreakpoints.kTabletWidth,
          minHeight: double.infinity,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeroCard(
                profileData: profileData,
                previewName: previewName,
                previewAvatarUrl: previewAvatarUrl,
                previewAvatarBytes: previewAvatarBytes,
                onAvatarEditPressed: onAvatarEditPressed,
              ),
              const SizedBox(height: 24),
              Form(
                key: cubit.formKey,
                child: SettingsOpaqueCard(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppField(
                          controller: cubit.nameController,
                          label: localization(context).name,
                          textInputAction: TextInputAction.done,
                          prefixIcon: SvgPicture.asset(
                            Assets.icons.person,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                              colorScheme(context).tertiaryFixed,
                              BlendMode.srcIn,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return localization(context).nameRequired;
                            }

                            return null;
                          },
                          onChanged: (_) => cubit.onFormChanged(),
                          onSubmitted: (_) async => await cubit.saveProfile(),
                        ),
                        const SizedBox(height: 18),
                        ProfileAvatarPickerField(
                          onAvatarEditPressed: onAvatarEditPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AppButton(
                onPressed: cubit.isSaving
                    ? null
                    : () async => await cubit.saveProfile(),
                isLoading: cubit.isSaving,
                label: localization(context).save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
