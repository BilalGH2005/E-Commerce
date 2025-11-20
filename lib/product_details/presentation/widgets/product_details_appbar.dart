import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/presentation/controllers/cart_cubit.dart';
import '../../../core/constants/app_routes.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartItemCount =
            context.read<CartCubit>().cartProducts.data?.length ?? 0;
        return AppBar(
          leading: AppBackButton(),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Badge(
                backgroundColor: colorScheme(context).primary,
                offset: Offset(3, 3),
                label: Text(
                  cartItemCount.toString(),
                  style: textTheme(context).titleSmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                isLabelVisible: cartItemCount > 0,
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
      },
    );
  }
}
