import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppBackButton()),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (_, state) => state is CartStateChanged,
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              final cartItemCount = cubit.cartProducts!.data!.length;
              return Badge(
                label: Text(cartItemCount.toString()),
                isLabelVisible: cartItemCount > 0,
                child: IconButton.filled(
                  tooltip: localization(context).cart,
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  onPressed: () async {
                    cubit.fetchCartItems();
                    await cubit.showCartDialog(context);
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
