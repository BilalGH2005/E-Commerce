import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../constants/assets.gen.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: localization(context).back,
      onPressed: onPressed ?? () => context.pop(),
      icon: SvgPicture.asset(
        Assets.icons.chevronLeft,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          colorScheme(context).inverseSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
