import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/widgets/oauth_button.dart';
import 'package:e_commerce/core/constants/assets.dart';
import 'package:e_commerce/core/themes/app_colors.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OAuthWidget extends StatelessWidget {
  const OAuthWidget({
    super.key,
    required this.label,
    required this.onPressed,
    required this.buttonText,
  });

  final String label;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<AppCubit>().isDarkTheme!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          localization(context).orContinueWith,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Theme.of(context).colorScheme.tertiaryFixed),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OAuthButton(
              iconPath: Assets.kGoogleIcon,
              onPressed: () async =>
                  await context.read<AuthCubit>().googleOAuth(),
              tooltip: localization(context).googleOAuth,
            ),
            OAuthButton(
              iconPath: Assets.kAppleIcon,
              onPressed: () => SnackBarUtil.showNotificationSnackBar(
                  context, localization(context).appleAccountsSoon),
              tooltip: localization(context).appleOAuth,
              colorFilter: isDarkTheme
                  ? ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            OAuthButton(
              iconPath: Assets.kFacebookIcon,
              onPressed: () => SnackBarUtil.showNotificationSnackBar(
                  context, localization(context).facebookAccountsSoon),
              tooltip: localization(context).facebookOAuth,
              colorFilter: isDarkTheme
                  ? ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    )
                  : null,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Theme.of(context).colorScheme.tertiaryFixed),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
