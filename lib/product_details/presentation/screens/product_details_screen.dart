import 'package:e_commerce/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/product_details/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shop/data/models/filtered_products_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/product_details_appbar.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final product = context.read<ProductDetailsCubit>().product.data!;
        return Scaffold(
          appBar: const ProductDetailsAppBar(),
          body: ResponsiveBuilder(
            mobile: (context) => _MobileLayout(product: product),
            tablet: (context) => _TabletLayout(product: product),
          ),
        );
      },
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final Product product;

  const _MobileLayout({required this.product});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ImagePane(imagesUrl: product.imagesUrls),
            const SizedBox(height: 24),
            _ProductDetails(product: product),
          ],
        ),
      );
}

class _TabletLayout extends StatelessWidget {
  final Product product;

  const _TabletLayout({required this.product});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppBreakpoints.kDesktopWidth,
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
                child: ImagePane(imagesUrl: product.imagesUrls),
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
    final width = MediaQuery.sizeOf(context).width;
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
          const SizedBox(height: 16),
          Text(
            'Colors',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          // ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: product.colors.length,
          //   itemBuilder: (context, index) => Container(
          //     width: 20,
          //     height: 20,
          //     color: AppColors.red,
          //   ),
          // ),
          const SizedBox(height: 24),
          width >= AppBreakpoints.kTabletWidth
              ? Column(children: actionButtons(context, product))
              : Row(children: actionButtons(context, product))
        ],
      ),
    );
  }
}

List<Widget> actionButtons(BuildContext context, Product product) => [
      CustomButton(
        colors: [AppColors.blue, AppColors.lightBlue],
        label: localization(context).addToCart,
        icon: Icons.shopping_cart_outlined,
        onPressed: () async =>
            await context.read<CartCubit>().addToCart(product: product),
        // await context.read<CartCubit>().fetchCartItems();
      ),
      SizedBox(height: 20),
      CustomButton(
        colors: [AppColors.green, AppColors.lightGreen],
        label: localization(context).buyNow,
        icon: Icons.touch_app_outlined,
        onPressed: () {},
      ),
    ];

class ImagePane extends StatelessWidget {
  final List<String> imagesUrl;

  const ImagePane({super.key, required this.imagesUrl});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final cubit = context.read<ProductDetailsCubit>();
          return Column(
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: cubit.imagesController,
                      itemCount: imagesUrl.length,
                      itemBuilder: (context, index) =>
                          CachedImage(imageUrl: imagesUrl[index]),
                    ),
                    Positioned(
                      left: 0,
                      child: IconButton.filled(
                          onPressed: () async =>
                              await cubit.goToPreviousImage(),
                          icon: Icon(Icons.arrow_back_ios_new_outlined)),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton.filled(
                          onPressed: () async => await cubit.goToNextImage(),
                          icon: Icon(Icons.arrow_forward_ios_outlined)),
                    ),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: cubit.imagesController,
                count: imagesUrl.length,
                effect: ExpandingDotsEffect(
                  radius: 40,
                  dotWidth: 10,
                  expansionFactor: 4,
                  activeDotColor:
                      Theme.of(context).colorScheme.onInverseSurface,
                  dotColor: Theme.of(context).colorScheme.tertiary,
                  dotHeight: 10,
                ),
              ),
            ],
          );
        },
      );
}
