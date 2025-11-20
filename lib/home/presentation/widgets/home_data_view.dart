import 'package:e_commerce/home/presentation/widgets/category_button.dart';
import 'package:e_commerce/collection/presentation/widgets/collection_card.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_products_grid_view.dart';
import '../../models/home_metadata_model.dart';
import 'new_products_carousel.dart';

class HomeDataView extends StatelessWidget {
  final HomeMetadataModel homeMetaDataModel;

  const HomeDataView({super.key, required this.homeMetaDataModel});

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverToBoxAdapter(
            child: Text(
              localization(context).welcomeToStylish,
              style: textTheme(context).displayLarge!.copyWith(
                color: colorScheme(context).inverseSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverToBoxAdapter(
            child: Text(
              localization(context).homeHeadlineText,
              style: textTheme(context).headlineMedium!.copyWith(
                color: colorScheme(context).tertiaryFixed,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            left: isRTL ? 0.0 : 32.0,
            right: isRTL ? 32.0 : 0.0,
          ),
          sliver: SliverToBoxAdapter(
            child: NewProductsCarousel(homeMetaDataModel.newProducts),
          ),
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
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverGrid.builder(
            itemCount: homeMetaDataModel.categories.length,
            itemBuilder: (context, index) =>
                CategoryButton(category: homeMetaDataModel.categories[index]),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 170,
              childAspectRatio: 170 / 205,
              mainAxisSpacing: 24,
              crossAxisSpacing: 18,
            ),
          ),
        ),
        const SliverSizedBox(height: 80),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverGrid.builder(
            itemCount: homeMetaDataModel.collections.length,
            itemBuilder: (context, index) => CollectionCard(
              collection: homeMetaDataModel.collections[index],
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 600,
              mainAxisSpacing: 16,
              crossAxisSpacing: 24,
              childAspectRatio: 311 / 377,
            ),
          ),
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
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          sliver: AppProductsGridView.sliver(
            itemCount: homeMetaDataModel.bestSeller.length,
            products: homeMetaDataModel.bestSeller,
          ),
        ),
      ],
    );
  }
}
