import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton.filled(
            style: IconButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainer),
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        )
      ],
    );
  }
}
