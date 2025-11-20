import 'package:e_commerce/cart/models/cart_item_model.dart';
import 'package:e_commerce/cart/presentation/widgets/quantity_modifier_widget.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/product_details/model/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/utils/shortcuts.dart';
import '../controllers/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    final cubit = context.read<CartCubit>();
    final orderDetails = OrderDetails(
      productId: cartItem.productId,
      colorId: cartItem.pickedColor.id,
      sizeId: cartItem.pickedSize.id,
    );

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pushNamed(
                      AppRoutes.productDetails.name,
                      pathParameters: {'product_id': cartItem.productId},
                    ),
                    child: CachedImage(
                      imageUrl: cartItem.imageUrl,
                      width: 130,
                      height: 125,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          cartItem.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme(
                            context,
                          ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${localization(context).color}: ${cartItem.pickedColor.name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme(context).labelSmall!.copyWith(
                            color: colorScheme(context).tertiaryFixedDim,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${localization(context).size}: ${cartItem.pickedSize.name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme(context).labelSmall!.copyWith(
                            color: colorScheme(context).tertiaryFixedDim,
                          ),
                        ),
                        SizedBox(height: 8),
                        cartItem.oldPrice != cartItem.newPrice
                            ? Row(
                                children: [
                                  Container(
                                    width: 84,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: colorScheme(context).tertiary,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '\$ ${cartItem.newPrice}',
                                        style: textTheme(context).displayMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '\$${cartItem.oldPrice}',
                                    style: textTheme(context).labelSmall!
                                        .copyWith(
                                          color: colorScheme(
                                            context,
                                          ).tertiaryFixedDim,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                ],
                              )
                            : Container(
                                width: 84,
                                height: 29,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colorScheme(context).tertiary,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '\$ ${cartItem.newPrice}',
                                    style: textTheme(context).displayMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                        SizedBox(height: 8),
                        QuantityModifierWidget(
                          quantity: cartItem.quantity,
                          decrementEvent: () async {
                            await cubit.removeFromCart(
                              orderDetails: orderDetails,
                            );
                          },
                          incrementEvent: () async {
                            await cubit.addToCart(orderDetails: orderDetails);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(color: colorScheme(context).tertiary),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${localization(context).totalOrders} (${cartItem.quantity}):',
                    style: textTheme(context).labelSmall,
                  ),
                  Text(
                    '\$${(cartItem.newPrice * cartItem.quantity).toStringAsFixed(2)}',
                    style: textTheme(
                      context,
                    ).labelSmall!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: isRTL ? null : 0,
          left: isRTL ? 0 : null,
          child: IconButton(
            onPressed: () async {
              await cubit.removeFromCart(orderDetails: orderDetails);
            },
            icon: Icon(
              Icons.close,
              color: colorScheme(context).tertiaryFixedDim,
            ),
          ),
        ),
      ],
    );
  }
}
