import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<CartCubit>();
    // final cartItemCount = cubit.cartProducts?.data?.length ?? 0;
    return AppBar(
      leading: AppBackButton(),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Badge(
            // TODO: remove static values
            label: Text(2.toString()),
            isLabelVisible: 2 > 0,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: colorScheme(context).surfaceContainer,
              ),
              tooltip: localization(context).cart,
              onPressed: () {
                context.goNamed(AppRoutes.cart.name);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
