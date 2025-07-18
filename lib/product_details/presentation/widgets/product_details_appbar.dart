import 'package:e_commerce/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final cartItemCount = cubit.cartProducts?.data?.length ?? 0;
    return AppBar(
      leading: AppBackButton(),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Badge(
            label: Text(cartItemCount.toString()),
            isLabelVisible: cartItemCount > 0,
            child: IconButton.filled(
              tooltip: localization(context).cart,
              onPressed: () async {
                cubit.fetchCartItems();
                await cubit.showCartDialog(context);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
