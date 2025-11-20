import 'package:e_commerce/cart/presentation/controllers/cart_cubit.dart';
import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:e_commerce/core/widgets/app_products_grid_view.dart';
import 'package:e_commerce/payment/presentation/controllers/payment_cubit.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_image.dart';
import 'package:e_commerce/product_details/presentation/widgets/size_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_color_button.dart';
import '../../model/product_details_model.dart';
import '../controllers/product_details_cubit.dart';
import 'custom_button.dart';

class MobileLayout extends StatelessWidget {
  final ProductDetailsModel product;

  const MobileLayout({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: ProductImage()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(child: _ProductDetails(product: product)),
          SliverToBoxAdapter(
            child: Text(
              localization(context).similarItems,
              style: textTheme(context).bodyMedium!.copyWith(
                color: colorScheme(context).inverseSurface,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 4)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: AppProductsGridView.sliver(
              itemCount: product.similarProducts.length,
              products: product.similarProducts,
            ),
          ),
        ],
      ),
    );
  }
}

class TabletLayout extends StatelessWidget {
  final ProductDetailsModel product;

  const TabletLayout({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _ProductDetails(product: product)),
                const SizedBox(width: 24),
                Expanded(child: ProductImage()),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              localization(context).similarItems,
              style: textTheme(context).bodyMedium!.copyWith(
                color: colorScheme(context).inverseSurface,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 4)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: AppProductsGridView.sliver(
              itemCount: product.similarProducts.length,
              products: product.similarProducts,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final ProductDetailsModel product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    final cubit = context.read<ProductDetailsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${localization(context).size}: ${product.sizes.firstWhere((size) => size.id == cubit.orderDetails.sizeId).name}',
          style: textTheme(
            context,
          ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.sizes.length,
            itemBuilder: (context, index) {
              final size = product.sizes[index];
              final isSelected = cubit.orderDetails.sizeId == size.id;

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizeButton(isSelected: isSelected, size: size),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Text(
          '${localization(context).color}: ${product.colors.firstWhere((color) => color.id == cubit.orderDetails.colorId).name}',
          style: textTheme(
            context,
          ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.colors.length,
            itemBuilder: (_, index) {
              final color = product.colors[index];
              final isSelected = cubit.orderDetails.colorId == color.id;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: AppColorButton(
                  color: color,
                  isSelected: isSelected,
                  onPressed: () {
                    if (!isSelected) {
                      cubit.updateOrderDetails(
                        cubit.orderDetails.copyWith(colorId: color.id),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Text(
          product.name,
          style: textTheme(
            context,
          ).bodyMedium?.copyWith(color: colorScheme(context).inverseSurface),
        ),
        const SizedBox(height: 8),
        product.price != product.finalPrice
            ? Row(
                children: [
                  Text(
                    '\$${product.price}',
                    style: textTheme(context).displaySmall!.copyWith(
                      color: colorScheme(context).tertiaryFixedDim,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: isRTL ? 10 : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '\$${product.finalPrice}',
                    style: textTheme(context).displaySmall!.copyWith(
                      color: colorScheme(context).inverseSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${product.category.discount!.round()}% ${localization(context).off}',
                    style: textTheme(context).displaySmall!.copyWith(
                      color: colorScheme(context).primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Text(
                '\$${product.price}',
                style: textTheme(
                  context,
                ).displaySmall!.copyWith(color: colorScheme(context).primary),
              ),
        const SizedBox(height: 8),
        Text(
          localization(context).productDetails,
          style: textTheme(
            context,
          ).displaySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(product.description, style: textTheme(context).bodySmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            CustomButton(
              colors: [AppColors.blue, AppColors.lightBlue],
              label: localization(context).addToCart,
              icon: Icons.shopping_cart_outlined,
              onPressed: () async {
                serviceLocator<CartCubit>().addToCart(
                  orderDetails: cubit.orderDetails,
                );
              },
            ),
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                return CustomButton(
                  colors: [AppColors.green, AppColors.lightGreen],
                  label: localization(context).buyNow,
                  icon: Icons.touch_app_outlined,
                  onPressed: () {
                    context.read<PaymentCubit>().createPaymentIntent(
                      amount: product.finalPrice,
                    );
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: colorScheme(context).primary.withAlpha(200),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization(context).deliveryIn,
                      style: textTheme(
                        context,
                      ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      localization(context).withinOneDay,
                      style: textTheme(context).bodyMedium!.copyWith(
                        color: colorScheme(context).inverseSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
