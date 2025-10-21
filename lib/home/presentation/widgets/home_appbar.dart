import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.gen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return AppBar(
      backgroundColor: colorScheme(context).surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.icons.appLogo, height: 31, width: 38),
          const SizedBox(width: 5),
          Text('Stylish', style: textTheme(context).headlineMedium),
        ],
      ),
      centerTitle: true,
      actions: [
        if (width >= AppBreakpoints.kTabletWidth)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: IconButton.filled(
              tooltip: localization(context).refresh,
              style: IconButton.styleFrom(
                backgroundColor: colorScheme(context).surfaceContainer,
              ),
              onPressed: () {},
              icon: const Icon(Icons.refresh_outlined),
              color: colorScheme(context).inverseSurface,
            ),
          ),
      ],
    );
  }
}
