import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/settings/presentation/controllers/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/assets.gen.dart';
import '../../../core/utils/shortcuts.dart';

class DeleteAccountDialog extends StatelessWidget {
  final String userId;

  const DeleteAccountDialog({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return AlertDialog(
          backgroundColor: colorScheme(context).surface,
          icon: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme(context).error.withAlpha(18),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              Assets.icons.trash,
              colorFilter: ColorFilter.mode(
                colorScheme(context).error,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
          ),
          title: Text(
            localization(context).areYouSure,
            style: textTheme(context).headlineMedium,
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 50,
                    child: AppButton(
                      color: colorScheme(context).tertiary,
                      onPressed: () => context.pop(),
                      labelWidget: Text(
                        localization(context).cancel,
                        style: TextStyle().copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: 50,
                    child: AppButton(
                      onPressed: () {
                        cubit.deleteUser(userId: userId);
                      },
                      color: colorScheme(context).error,
                      labelWidget: !cubit.isLoading
                          ? Text(
                              localization(context).deleteAccount,
                              style: TextStyle().copyWith(
                                color: AppColors.white,
                              ),
                            )
                          : CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
