import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '- Or continue with -',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Color(0xFF575757)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OAuthButton(
                iconPath: 'assets/images/google_icon.svg',
                onPressed: () async =>
                    await context.read<AuthCubit>().googleOAuth(),
              ),
              OAuthButton(
                iconPath: 'assets/images/apple_icon.svg',
                onPressed: () => SnackBarUtil.showNotificationSnackBar(
                    context, 'Apple accounts will be supported soon.'),
              ),
              OAuthButton(
                iconPath: 'assets/images/facebook_icon.svg',
                onPressed: () => SnackBarUtil.showNotificationSnackBar(
                    context, 'Facebook accounts will be supported soon.'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              TextButton(
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
