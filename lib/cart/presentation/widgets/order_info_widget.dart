import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../controllers/cart_cubit.dart';

class OrderInfoWidget extends StatelessWidget {
  final double subTotal;
  final double total;

  const OrderInfoWidget({
    super.key,
    required this.subTotal,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization(context).orderInfo,
          style: textTheme(
            context,
          ).displayMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization(context).subtotal,
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '\$${subTotal.toStringAsFixed(2)}',
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization(context).shippingCost,
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '+ \$${cubit.shippingCost.toStringAsFixed(2)}',
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization(context).couponDiscount,
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '- \$${cubit.couponDiscount.toStringAsFixed(2)}',
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization(context).total,
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: textTheme(
                context,
              ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
