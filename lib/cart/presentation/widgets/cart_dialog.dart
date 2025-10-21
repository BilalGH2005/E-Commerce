import 'package:e_commerce/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_item_card.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:e_commerce/core/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartDialog extends StatelessWidget {
  const CartDialog({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 150,
        maxWidth: 800,
        minHeight: 200,
        maxHeight: 600,
      ),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          return Dialog(
            insetPadding: const EdgeInsets.all(8.0),
            backgroundColor: colorScheme(context).surface,
            child: AsyncValueBuilder(
              value: cubit.cartProducts!,
              loading: (context) =>
                  const Center(child: CircularProgressIndicator()),
              data: (context, cartItems) => Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: AppBackButton(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) =>
                          CartItemCard(cartItems[index]),
                    ),
                  ),
                ],
              ),
              error: (context, _) => AppErrorWidget(
                error: localization(context).retry,
                labelWidget: Text(
                  localization(context).retry,
                  style: textTheme(context).bodyMedium,
                ),
                onPressed: () async {
                  await cubit.fetchCartItems();
                },
              ),
            ),
          );
        },
      ),
    ),
  );
}
