import 'package:e_commerce/core/utils/async.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:e_commerce/core/widgets/app_error_widget.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/widgets/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartDialog extends StatelessWidget {
  const CartDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 150, maxWidth: 800, minHeight: 200, maxHeight: 600),
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (_, state) => state is CartStateChanged,
          builder: (context, state) {
            final cartItems = context.read<HomeCubit>().cartProducts;
            return Dialog(
              insetPadding: EdgeInsets.all(8.0),
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: AsyncBuilder(
                value: cartItems!,
                loading: (context) =>
                    Center(child: CircularProgressIndicator()),
                data: (context, cartItems) => Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: AppBackButton()),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) =>
                            CartProduct(product: cartItems[index]),
                      ),
                    ),
                  ],
                ),
                error: (context, error) => AppErrorWidget(
                    error: localization(context).somethingWentWrong,
                    buttonLabel: localization(context).retry),
              ),
            );
          },
        ),
      ),
    );
  }
}
