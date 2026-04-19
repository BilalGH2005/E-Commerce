import 'package:e_commerce/cart/models/cart_item_model.dart';
import 'package:e_commerce/cart/presentation/widgets/quantity_modifier_widget.dart';
import 'package:e_commerce/core/models/category.dart';
import 'package:e_commerce/core/models/json_color.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/product_details/model/order_details.dart';
import 'package:e_commerce/product_details/model/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/utils/shortcuts.dart';
import '../controllers/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard(this.cartItem, {super.key});

  Widget _specChip(
    BuildContext context, {
    required String label,
    IconData? icon,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme(context).surface.withAlpha(170),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme(context).tertiary.withAlpha(160)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: iconColor ?? colorScheme(context).primary,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: textTheme(context).titleSmall?.copyWith(
              color: colorScheme(context).onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final orderDetails = OrderDetails(
      productId: cartItem.productId,
      colorId: cartItem.pickedColor.id,
      sizeId: cartItem.pickedSize.id,
    );
    final product = ProductDetailsModel(
      id: cartItem.productId,
      name: cartItem.productName,
      imagesUrls: [cartItem.imageUrl],
      colors: [
        JsonColor(
          id: cartItem.pickedColor.id,
          name: cartItem.pickedColor.name,
          hexCode: '',
        ),
      ],
      sizes: [cartItem.pickedSize],
      price: cartItem.oldPrice,
      finalPrice: cartItem.newPrice,
      similarProducts: [],
      category: Category(id: 'id', name: 'name'),
      description: '',
      addedAt: DateTime.now(),
    );
    final hasDiscount = cartItem.oldPrice > cartItem.newPrice;
    final discountPercent = hasDiscount && cartItem.oldPrice > 0
        ? (((cartItem.oldPrice - cartItem.newPrice) / cartItem.oldPrice) * 100)
              .round()
        : 0;
    final totalPrice = (cartItem.newPrice * cartItem.quantity).toStringAsFixed(
      2,
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: colorScheme(context).surfaceContainerHighest.withAlpha(110),
        border: Border.all(color: colorScheme(context).tertiary.withAlpha(140)),
        // boxShadow: [
        //   BoxShadow(
        //     color: colorScheme(context).shadow.withAlpha(22),
        //     blurRadius: 24,
        //     offset: const Offset(0, 10),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(
                  AppRoutes.productDetails.name,
                  pathParameters: {'product_id': cartItem.productId},
                ),
                child: Container(
                  width: 118,
                  height: 126,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorScheme(context).surface.withAlpha(160),
                  ),
                  child: CachedImage(
                    imageUrl: cartItem.imageUrl,
                    width: 106,
                    height: 114,
                    borderRadius: 16,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            cartItem.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme(context).displaySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Material(
                          color: colorScheme(context).surface.withAlpha(170),
                          shape: const CircleBorder(),
                          child: IconButton(
                            onPressed: () {
                              cubit.removeFromCartEntirely(
                                orderDetails: orderDetails,
                              );
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              color: colorScheme(context).tertiaryFixedDim,
                            ),
                            splashRadius: 18,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _specChip(
                          context,
                          label:
                              '${localization(context).color}: ${cartItem.pickedColor.name}',
                          icon: Icons.palette_outlined,
                        ),
                        _specChip(
                          context,
                          label:
                              '${localization(context).size}: ${cartItem.pickedSize.name}',
                          icon: Icons.straighten_rounded,
                        ),
                        if (hasDiscount)
                          _specChip(
                            context,
                            label: '-$discountPercent%',
                            icon: Icons.local_offer_outlined,
                            iconColor: colorScheme(context).primary,
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: colorScheme(context).surface.withAlpha(170),
                            border: Border.all(
                              color: colorScheme(
                                context,
                              ).tertiary.withAlpha(110),
                            ),
                          ),
                          child: QuantityModifierWidget(
                            quantity: cartItem.quantity,
                            decrementEvent: () {
                              cubit.removeFromCart(orderDetails: orderDetails);
                            },
                            incrementEvent: () {
                              cubit.addToCart(product: product);
                            },
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${cartItem.newPrice.toStringAsFixed(2)}',
                              style: textTheme(context).headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme(context).onSurface,
                                  ),
                            ),
                            if (hasDiscount)
                              Text(
                                '\$${cartItem.oldPrice.toStringAsFixed(2)}',
                                style: textTheme(context).labelSmall?.copyWith(
                                  color: colorScheme(context).tertiaryFixedDim,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: colorScheme(context).surface.withAlpha(160),
              border: Border.all(
                color: colorScheme(context).tertiary.withAlpha(90),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization(context).total,
                      style: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).tertiaryFixedDim,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${localization(context).totalOrders} (${cartItem.quantity})',
                      style: textTheme(context).labelSmall?.copyWith(
                        color: colorScheme(context).onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$$totalPrice',
                  style: textTheme(context).displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme(context).primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
