import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:e_commerce/settings/presentation/controllers/settings_cubit.dart';
import 'package:e_commerce/settings/presentation/widgets/profile_avatar_source_sheet.dart';
import 'package:e_commerce/settings/presentation/widgets/profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().hydrateProfileFromCurrentUser();
  }

  Future<void> _showAvatarSourceSheet() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final cubit = context.read<SettingsCubit>();
    final action = await showModalBottomSheet<ProfileAvatarSourceAction>(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return ProfileAvatarSourceSheet(hasAvatar: cubit.hasAvatarDraft);
      },
    );

    if (!mounted || action == null) {
      return;
    }

    if (action == ProfileAvatarSourceAction.remove) {
      cubit.setAvatarDraft(null);
      return;
    }

    final errorCode = action == ProfileAvatarSourceAction.camera
        ? await cubit.pickAvatarFromCamera()
        : await cubit.pickAvatarFromGallery();

    if (!mounted || errorCode == null) {
      return;
    }

    SnackBarUtil.showError(_profileErrorMessage(context, errorCode));
  }

  String _profileErrorMessage(BuildContext context, String errorCode) {
    if (errorCode == 'noInternetConnection') {
      return localization(context).noInternetConnection;
    }

    return localization(context).authError(errorCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colorScheme(context).surface,
        backgroundColor: colorScheme(context).surface,
        leading: const AppBackButton(),
        centerTitle: true,
        title: Text(
          localization(context).editProfile,
          style: textTheme(
            context,
          ).bodyMedium?.copyWith(color: colorScheme(context).inverseSurface),
        ),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listenWhen: (_, state) =>
            state is SettingsSaveSuccess || state is SettingsSaveFailure,
        listener: (context, state) {
          if (state is SettingsSaveSuccess) {
            FocusManager.instance.primaryFocus?.unfocus();
            SnackBarUtil.showSuccess(
              localization(context).changesAppliedSuccessfully,
            );
          } else if (state is SettingsSaveFailure) {
            SnackBarUtil.showError(
              _profileErrorMessage(context, state.errorCode),
            );
          }
        },
        builder: (context, state) {
          final profileData = context.read<SettingsCubit>().profile.data;

          if (profileData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ProfileScreenBody(
            profileData: profileData,
            onAvatarEditPressed: () {
              _showAvatarSourceSheet();
            },
          );
        },
      ),
    );
  }
}
