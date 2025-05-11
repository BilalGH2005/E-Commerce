import 'package:e_commerce/core/constants/assets.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.kAppLogo,
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
        if (getDeviceType(width) == DeviceType.tablet)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: IconButton.filled(
              tooltip: localization(context).refresh,
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
