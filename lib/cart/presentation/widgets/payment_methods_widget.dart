import 'package:e_commerce/cart/presentation/widgets/shipping_method_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../controllers/cart_cubit.dart';

class PaymentMethodsWidget extends StatelessWidget {
  const PaymentMethodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return RadioGroup(
      groupValue: cubit.shippingCost,
      onChanged: cubit.onPaymentMethodChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization(context).paymentMethods,
            style: textTheme(
              context,
            ).displayMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          ShippingMethodRadio(
            value: 0.00,
            title: localization(context).freeShipping,
          ),
          SizedBox(height: 12),
          ShippingMethodRadio(
            value: 5.00,
            title: localization(context).standardShipping,
          ),
          SizedBox(height: 12),
          ShippingMethodRadio(
            value: 15.00,
            title: localization(context).expressShipping,
          ),
        ],
      ),
    );
  }
}
