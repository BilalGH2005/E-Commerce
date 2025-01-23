import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/snackbar_util.dart';
import '../cubit/auth_cubit.dart';
import 'oauth_button.dart';

class OAuthButtons extends StatelessWidget {
  const OAuthButtons({
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
          const Text(
            '- Or continue with -',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Constants.kNiceGrey,
            ),
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
                onPressed: () => SnackBarUtil.showErrorSnackBar(
                    context, 'Apple accounts will be supported soon.'),
              ),
              OAuthButton(
                iconPath: 'assets/images/facebook_icon.svg',
                onPressed: () => SnackBarUtil.showErrorSnackBar(
                    context, 'Facebook accounts will be supported soon.'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontFamily: 'Montserrat', color: Constants.kNiceGrey),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ],
      );
}
