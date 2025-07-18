import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../shop/data/models/filtered_products_model.dart';

class ItemCard extends StatelessWidget {
  final Product product;

  const ItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.pushNamed(AppRoutes.productDetails.name,
            pathParameters: {'product_id': product.id}),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: CachedImage(
                  imageUrl: product.imagesUrls[0],
                  width: double.infinity,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
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
              ),
            ],
          ),
        ),
      );
}
