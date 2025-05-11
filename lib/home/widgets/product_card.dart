import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum ProductCardType {
  normal,
  newProduct,
  cart,
  search,
}

class ProductCardBuilder extends StatelessWidget {
  final Product product;
  final ProductCardType type;

  const ProductCardBuilder({
    super.key,
    required this.product,
    this.type = ProductCardType.normal,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ProductCardType.newProduct:
        return _buildNewProductCard(context);
      case ProductCardType.cart:
        return _buildCartProductCard(context);
      case ProductCardType.search:
        return _buildSearchProductCard(context);
      case ProductCardType.normal:
        return _buildNormalCard(context);
    }
  }

  Widget _buildNormalCard(BuildContext context) => InkWell(
        onTap: () => context.pushNamed(ScreensNames.product, extra: product),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: CachedImage(
                  imageUrl: product.imageUrl,
                  width: double.infinity,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _productDetails(context),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildNewProductCard(BuildContext context) => InkWell(
        onTap: () => context.pushNamed(ScreensNames.product, extra: product),
        child: Banner(
          message: localization(context).newProduct,
          location: BannerLocation.topStart,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CachedImage(
                    imageUrl: product.imageUrl,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _productDetails(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildCartProductCard(BuildContext context) => InkWell(
        onTap: () => context.pushNamed(ScreensNames.product, extra: product),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CachedImage(
                      imageUrl: product.imageUrl, width: 125, height: 125),
                  const SizedBox(width: 8),
                  Expanded(child: _productDetails(context)),
                ],
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Orders (X):',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      '\$${product.price}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildSearchProductCard(BuildContext context) => InkWell(
        onTap: () => context.pushNamed(ScreensNames.product, extra: product),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CachedImage(
                  imageUrl: product.imageUrl,
                  width: double.infinity,
                  height: 100,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _productDetails(context),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _productDetails(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            '\$${product.price}',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      );
}
