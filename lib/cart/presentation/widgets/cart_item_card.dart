import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/models/product.dart';
import '../../../core/utils/shortcuts.dart';

class CartItemCard extends StatelessWidget {
  final Product product;

  const CartItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => context.pushNamed(
      AppRoutes.productDetails.name,
      pathParameters: {'product_id': product.id},
    ),
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme(context).surfaceContainer,
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
                      style: textTheme(context).displayMedium,
                    ),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme(context).titleSmall,
                    ),
                    Text(
                      '\$${product.price}',
                      style: textTheme(context).labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: colorScheme(context).tertiary),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Orders (X):', style: textTheme(context).labelSmall),
                Text(
                  '\$${product.price}',
                  style: textTheme(
                    context,
                  ).labelSmall!.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
