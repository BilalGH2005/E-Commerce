import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OAuthButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  const OAuthButton(
      {super.key, required this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            shape: BoxShape.circle),
        child: SizedBox(
          width: 54,
          height: 54,
          child: IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset(
              iconPath,
              height: 26,
              width: 26,
            ),
          ),
        ),
      );
}
