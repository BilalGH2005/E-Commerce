import 'dart:math';

import 'package:e_commerce/cart/models/cart_item_model.dart';
import 'package:e_commerce/cart/presentation/controllers/cart_cubit.dart';
import 'package:e_commerce/cart/presentation/widgets/coupon_widget.dart';
import 'package:e_commerce/cart/presentation/widgets/empty_cart_widget.dart';
import 'package:e_commerce/cart/presentation/widgets/order_info_widget.dart';
import 'package:e_commerce/cart/presentation/widgets/payment_methods_widget.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/payment/presentation/controllers/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/snackbar_util.dart';
import 'cart_item_card.dart';

class CartDataView extends StatelessWidget {
  final List<CartItem> cartProducts;

  const CartDataView({required this.cartProducts, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    final subTotal = cartProducts.fold<double>(0, (sum, item) {
      return sum + (item.newPrice * item.quantity);
    });

    final double total = max(
      subTotal + cubit.shippingCost - cubit.couponDiscount,
      0,
    );

    return BlocConsumer<PaymentCubit, PaymentState>(
      listenWhen: (_, state) =>
          state is PaymentFailed || state is PaymentSuccessful,
      listener: (context, state) {
        if (state is PaymentSuccessful) {
          context.read<PaymentCubit>().showSuccessfulPaymentDialog(context);
        } else if (state is PaymentFailed) {
          SnackBarUtil.showError(localization(context).somethingWentWrong);
        }
      },
      builder: (context, state) {
        return cartProducts.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverGrid.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(cartProducts[index]);
                    },
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 550,
                      mainAxisExtent: 250,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization(context).applyCoupon,
                          style: textTheme(context).displayMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16),
                        CouponWidget(),
                      ],
                    ),
                  ),
                  SliverSizedBox(height: 32),
                  SliverToBoxAdapter(child: PaymentMethodsWidget()),
                  SliverSizedBox(height: 32),
                  SliverToBoxAdapter(
                    child: OrderInfoWidget(subTotal: subTotal, total: total),
                  ),
                  SliverSizedBox(height: 32),
                  SliverToBoxAdapter(
                    child: AppButton(
                      onPressed: context.read<PaymentCubit>().isLoading
                          ? null
                          : () {
                              context.read<PaymentCubit>().presentPaymentSheet(
                                amount: (double.parse(
                                  total.toStringAsFixed(2),
                                )),
                                context: context,
                              );
                            },
                      labelWidget: context.read<PaymentCubit>().isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              localization(context).checkout,
                              style: textTheme(context).bodyMedium,
                            ),
                    ),
                  ),
                  SliverSizedBox(height: 8),
                ],
              )
            : EmptyCartWidget();
      },
    );
  }
}
