import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/asset_images_paths.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 768;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetImagesPaths.kAppLogo,
            height: 31,
            width: 38,
          ),
          const SizedBox(width: 5),
          Text(
            'E-Commerce',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        if (isWideScreen)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: IconButton.filled(
              tooltip: AppLocalizations.of(context)!.refresh,
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              ),
              onPressed: () => context.read<HomeCubit>().fetchProducts(),
              icon: const Icon(Icons.refresh_outlined),
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
      ],
    );
  }
}
