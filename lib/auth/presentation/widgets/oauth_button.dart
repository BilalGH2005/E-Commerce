import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/shortcuts.dart';

class OAuthButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final ColorFilter? colorFilter;
  final String? tooltip;

  const OAuthButton({
    super.key,
    required this.iconPath,
    required this.onPressed,
    this.tooltip,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: colorScheme(context).primary),
      shape: BoxShape.circle,
    ),
    child: SizedBox(
      width: 54,
      height: 54,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: SvgPicture.asset(
          iconPath,
          height: 26,
          width: 26,
          colorFilter: colorFilter,
        ),
      ),
    ),
  );
}
