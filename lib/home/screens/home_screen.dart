import 'package:e_commerce/core/utils/asset_images_paths.dart';
import 'package:e_commerce/core/utils/async.dart';
import 'package:e_commerce/home/widgets/products_grid.dart';
import 'package:e_commerce/home/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/reusable_widgets/reusable_error_widget.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    useEffect(() {
      context.read<HomeCubit>().fetchProducts();
      context.read<HomeCubit>().fetchCartItems();
      return null;
    }, []);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          //TODO: solve appbar color to be const (terms appbar too)
          appBar: AppBar(
            actions: isWideScreen
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: IconButton.filled(
                        // tooltip: AppLocalizations.of(context)!.cart,
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                        ),
                        onPressed: () {
                          context.read<HomeCubit>().fetchProducts();
                        },
                        icon: const Icon(Icons.refresh_outlined),
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ]
                : null,
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
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: AsyncBuilder(
              value: cubit.products!,
              loading: (context) {
                return const ShimmerWidget();
              },
              data: (context, products) {
                return ProductsGrid(products: products);
              },
              error: (context, error) {
                return ReusableErrorWidget(
                    error: AppLocalizations.of(context)!.somethingWentWrong,
                    buttonLabel: AppLocalizations.of(context)!.retry);
              },
            ),
          ),
        );
      },
    );
  }
}
