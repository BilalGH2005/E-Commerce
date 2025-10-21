import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_error_widget.dart';
import 'package:e_commerce/product_details/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/product_details_appbar.dart';
import '../widgets/screen_layouts.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductDetailsAppBar(),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final cubit = context.read<ProductDetailsCubit>();
          return AsyncValueBuilder(
            value: cubit.product,
            loading: (context) => Center(child: CircularProgressIndicator()),
            data: (context, product) => ResponsiveBuilder(
              mobile: (context) => MobileLayout(product: product),
              tablet: (context) => TabletLayout(product: product),
            ),
            error: (context, error) => AppErrorWidget(
              error: localization(context).somethingWentWrong,
              labelWidget: Text(
                localization(context).retry,
                style: textTheme(
                  context,
                ).bodyMedium!.copyWith(color: colorScheme(context).surface),
              ),
              onPressed: () {
                cubit.getProductDetails(
                  productId: GoRouterState.of(
                    context,
                  ).pathParameters['product_id']!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
