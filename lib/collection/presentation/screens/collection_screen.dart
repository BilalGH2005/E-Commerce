import 'package:e_commerce/collection/presentation/controllers/collection_cubit.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/widgets/app_products_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_error_widget.dart';

class CollectionScreen extends StatelessWidget {
  final String collectionName;

  const CollectionScreen({super.key, required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colorScheme(context).surface,
        backgroundColor: colorScheme(context).surface,

        centerTitle: true,
        title: Text(
          collectionName,
          style: textTheme(
            context,
          ).bodyMedium!.copyWith(color: colorScheme(context).inverseSurface),
        ),
      ),
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, state) {
          final cubit = context.read<CollectionCubit>();
          return AsyncValueBuilder(
            value: cubit.collectionProducts,
            loading: (_) => Center(child: CircularProgressIndicator()),
            data: (_, collectionProducts) => AppProductsGridView(
              itemCount: collectionProducts.length,
              products: collectionProducts,
              padding: EdgeInsets.symmetric(horizontal: 32),
            ),
            error: (context, error) => AppErrorWidget(
              error: localization(context).somethingWentWrong,
              labelWidget: Text(
                localization(context).retry,
                style: textTheme(
                  context,
                ).bodyMedium!.copyWith(color: AppColors.white),
              ),
              onPressed: () {
                cubit.getCollectionProducts(collectionId: cubit.collectionId);
              },
            ),
          );
        },
      ),
    );
  }
}
