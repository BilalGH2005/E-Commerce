import 'package:e_commerce/core/constants/breakpoints.dart';
import 'package:e_commerce/core/themes/app_colors.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/custom_button.dart';
import 'package:e_commerce/home/widgets/product_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductAppBar(),
      body: ResponsiveBuilder(
        mobile: (context) => _MobileLayout(product: product),
        tablet: (context) => _TabletLayout(product: product),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final Product product;
  const _MobileLayout({required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CachedImage(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            imageUrl: product.imageUrl,
          ),
          const SizedBox(height: 24),
          _ProductDetails(product: product),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final Product product;
  const _TabletLayout({required this.product});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Breakpoints.desktopWidth,
          minHeight: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _ProductDetails(product: product)),
              const SizedBox(width: 24),
              Expanded(
                child: CachedImage(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: product.imageUrl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;
  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            localization(context).productDetails,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          _ActionButtons(product: product),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Product product;
  const _ActionButtons({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          colors: [AppColors.blue, AppColors.lightBlue],
          label: localization(context).addToCart,
          icon: Icons.shopping_cart_outlined,
          onPressed: () => context
              .read<HomeCubit>()
              .addToCart(context: context, product: product),
          // context.read<HomeCubit>().fetchCartItems();
        ),
        const SizedBox(width: 10),
        CustomButton(
          colors: [AppColors.green, AppColors.lightGreen],
          label: localization(context).buyNow,
          icon: Icons.touch_app_outlined,
          onPressed: () {},
        ),
      ],
    );
  }
}
