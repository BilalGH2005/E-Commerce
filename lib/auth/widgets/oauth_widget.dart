import 'package:e_commerce/app/cubit/app_cubit.dart';
import 'package:e_commerce/core/themes/const_colors.dart';
import 'package:e_commerce/core/utils/asset_images_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/snackbar_util.dart';
import '../cubit/auth_cubit.dart';
import 'oauth_button.dart';

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
          AppLocalizations.of(context)!.orContinueWith,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Theme.of(context).colorScheme.tertiaryFixed),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OAuthButton(
              iconPath: AssetImagesPaths.kGoogleIcon,
              onPressed: () async =>
                  await context.read<AuthCubit>().googleOAuth(),
              tooltip: AppLocalizations.of(context)!.googleOAuth,
            ),
            OAuthButton(
              iconPath: AssetImagesPaths.kAppleIcon,
              onPressed: () => SnackBarUtil.showNotificationSnackBar(
                  context, AppLocalizations.of(context)!.appleAccountsSoon),
              tooltip: AppLocalizations.of(context)!.appleOAuth,
              colorFilter: isDarkTheme
                  ? ColorFilter.mode(
                      ConstColors.white,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            OAuthButton(
              iconPath: AssetImagesPaths.kFacebookIcon,
              onPressed: () => SnackBarUtil.showNotificationSnackBar(
                  context, AppLocalizations.of(context)!.facebookAccountsSoon),
              tooltip: AppLocalizations.of(context)!.facebookOAuth,
              colorFilter: isDarkTheme
                  ? ColorFilter.mode(
                      ConstColors.white,
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
