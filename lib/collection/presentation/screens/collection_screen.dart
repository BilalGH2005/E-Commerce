import 'package:e_commerce/collection/cubit/collection_cubit.dart';
import 'package:e_commerce/core/widgets/app_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_error_widget.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, state) {
          final cubit = context.read<CollectionCubit>();
          return AsyncValueBuilder(
            value: cubit.collectionProducts,
            loading: (context) => Center(child: CircularProgressIndicator()),
            data: (context, collectionProducts) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 152 + 32,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  childAspectRatio: 152 / 314,
                ),
                itemCount: collectionProducts.length,
                itemBuilder: (context, index) =>
                    AppItemCard(collectionProducts[index]),
              ),
            ),
            error: (context, error) => AppErrorWidget(
              error: localization(context).somethingWentWrong,
              labelWidget: Text(
                localization(context).retry,
                style: textTheme(context).bodyMedium,
              ),
              onPressed: () async {
                return cubit.getCollectionProducts(
                  collectionId: cubit.collectionId,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
