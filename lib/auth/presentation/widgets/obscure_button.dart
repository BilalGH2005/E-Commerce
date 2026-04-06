import 'package:e_commerce/core/constants/assets.gen.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObscureButton extends StatelessWidget {
  final bool isObscure;
  final VoidCallback onPressed;

  const ObscureButton({
    super.key,
    required this.isObscure,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: onPressed,
      focusNode: FocusNode(skipTraversal: true),
      icon: isObscure
          ? SvgPicture.asset(
              Assets.icons.eyeOff,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                colorScheme(context).tertiaryFixed,
                BlendMode.srcIn,
              ),
            )
          : SvgPicture.asset(
              Assets.icons.eye,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                colorScheme(context).tertiaryFixed,
                BlendMode.srcIn,
              ),
            ),
    );
  }
}
