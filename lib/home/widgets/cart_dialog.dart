import 'package:e_commerce/core/reusable_widgets/reusable_back_button.dart';
import 'package:e_commerce/core/utils/async.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/reusable_widgets/reusable_error_widget.dart';

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
            final cartItems = context.read<HomeCubit>().cartItems;
            return Dialog(
              insetPadding: EdgeInsets.all(8.0),
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: AsyncBuilder(
                value: cartItems,
                loading: (context) {
                  return Center(child: CircularProgressIndicator());
                },
                data: (context, cartItems) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ReusableBackButton()),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final product = cartItems[index];
                            return CartItem(product: product);
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (context, error) {
                  return ReusableErrorWidget(
                      error: AppLocalizations.of(context)!.somethingWentWrong,
                      buttonLabel: AppLocalizations.of(context)!.retry);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
