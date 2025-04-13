import 'package:e_commerce/core/reusable_widgets/reusable_back_button.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ReusableBackButton()),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final cartItemCount =
                  context.read<HomeCubit>().cartItems.data!.length;
              return Badge(
                label: Text(cartItemCount.toString()),
                isLabelVisible: cartItemCount > 0,
                child: IconButton.filled(
                  tooltip: AppLocalizations.of(context)!.cart,
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  onPressed: () async {
                    context.read<HomeCubit>().fetchCartItems();
                    await context.read<HomeCubit>().showCartDialog(context);
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
