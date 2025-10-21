import 'package:e_commerce/core/widgets/app_item_card.dart';
import 'package:e_commerce/home/presentation/widgets/category_button.dart';
import 'package:e_commerce/collection/presentation/widgets/collection_card.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/home/data/models/home_metadata_model.dart';
import '../../../core/utils/shortcuts.dart';
import 'new_products_carousel.dart';

class HomeDataView extends StatelessWidget {
  final HomeMetadataModel homeMetaDataModel;

  const HomeDataView({super.key, required this.homeMetaDataModel});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Text(
            localization(context).welcomeToStylish,
            style: textTheme(context).displayLarge!.copyWith(
              color: colorScheme(context).inverseSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            localization(context).homeHeadlineText,
            style: textTheme(context).headlineMedium!.copyWith(
              color: colorScheme(context).tertiaryFixed,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: NewProductsCarousel(homeMetaDataModel.newProducts),
        ),
        const SliverSizedBox(height: 40),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localization(context).shopByCategories,
                textAlign: TextAlign.center,
                style: textTheme(context).displayLarge!.copyWith(
                  color: colorScheme(context).inverseSurface,
                ),
              ),
            ],
          ),
        ),
        const SliverSizedBox(height: 48),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 152 + 32,
            mainAxisSpacing: 24,
            crossAxisSpacing: 18,
            childAspectRatio: 152 / 192,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                CategoryButton(category: homeMetaDataModel.categories[index]),
            childCount: homeMetaDataModel.categories.length,
          ),
        ),

        const SliverSizedBox(height: 80),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisSpacing: 16,
            crossAxisSpacing: 24,
            childAspectRatio: 311 / 377,
          ),
          itemCount: homeMetaDataModel.collections.length,
          itemBuilder: (context, index) =>
              CollectionCard(collection: homeMetaDataModel.collections[index]),
        ),

        const SliverSizedBox(height: 80),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localization(context).bestSeller,
                style: textTheme(context).displayLarge!.copyWith(
                  color: colorScheme(context).inverseSurface,
                ),
              ),
            ],
          ),
        ),
        const SliverSizedBox(height: 16),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 152,
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            childAspectRatio: 152 / 314,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                AppItemCard(homeMetaDataModel.bestSeller[index]),
            childCount: homeMetaDataModel.bestSeller.length,
          ),
        ),
      ],
    );
  }
}
