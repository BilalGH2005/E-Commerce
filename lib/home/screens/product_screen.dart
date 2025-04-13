import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/product_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/reusable_widgets/reusable_cached_image.dart';
import '../widgets/custom_button.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 700;
          final screenHeight = MediaQuery.sizeOf(context).height;

          final imageSection = ReusableCachedImage(
            imageUrl: product.imageUrl,
            height: isWideScreen ? screenHeight : screenHeight * 0.4,
            width: double.infinity,
          );

          final detailsSection = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.productDetails,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    CustomButton(
                      colors: [
                        const Color(0xFF0B3689),
                        const Color(0xFF3F92FF)
                      ],
                      label: AppLocalizations.of(context)!.addToCart,
                      icon: Icons.shopping_cart_outlined,
                      onPressed: () {
                        context.read<HomeCubit>().addToCart(product);
                        context.read<HomeCubit>().fetchCartItems();
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      colors: [
                        const Color(0xFF31B769),
                        const Color(0xFF71F9A9)
                      ],
                      label: AppLocalizations.of(context)!.buyNow,
                      icon: Icons.touch_app_outlined,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );

          return isWideScreen
              ? Center(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 1000, minHeight: screenHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: detailsSection,
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 5,
                            child: imageSection,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        imageSection,
                        const SizedBox(height: 24),
                        detailsSection,
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
