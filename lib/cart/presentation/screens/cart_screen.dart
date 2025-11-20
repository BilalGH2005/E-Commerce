import 'package:e_commerce/cart/presentation/widgets/cart_data_view.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/app_error_widget.dart';
import '../controllers/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listenWhen: (_, state) =>
          state is CartCouponAppliedState ||
          state is CartCouponDoesNotExistState ||
          state is CartFailedState,
      listener: (context, state) {
        if (state is CartCouponDoesNotExistState) {
          SnackBarUtil.showError(localization(context).invalidCouponCode);
        } else if (state is CartCouponAppliedState) {
          SnackBarUtil.showSuccess(
            localization(context).couponAppliedSuccessfully,
          );
        } else if (state is CartFailedState) {
          SnackBarUtil.showError(localization(context).somethingWentWrong);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 32.0,
                left: 32.0,
              ),
              child: AsyncValueBuilder(
                value: cubit.cartProducts,
                loading: (_) => Center(child: CircularProgressIndicator()),
                data: (_, cartProducts) =>
                    CartDataView(cartProducts: cartProducts),
                error: (_, _) => Center(
                  child: AppErrorWidget(
                    error: localization(context).somethingWentWrong,
                    labelWidget: Text(
                      localization(context).retry,
                      style: textTheme(context).bodyMedium!.copyWith(
                        color: colorScheme(context).surface,
                      ),
                    ),
                    onPressed: () async {
                      await cubit.getCartItems();
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
