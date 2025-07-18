import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../shop/data/models/filtered_products_model.dart';

class CartItemCard extends StatelessWidget {
  final Product product;

  const CartItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.pushNamed(AppRoutes.productDetails.name,
            pathParameters: {'product_id': product.id}),
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
                    imageUrl: product.imagesUrls[0],
                    width: 125,
                    height: 125,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
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
                    ),
                  ),
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
}
