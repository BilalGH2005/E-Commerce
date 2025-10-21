import 'package:e_commerce/core/models/product_preview.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_routes.dart';

class AppItemCard extends StatelessWidget {
  final ProductPreview product;

  const AppItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      context.pushNamed(
        AppRoutes.productDetails.name,
        pathParameters: {'product_id': product.id},
      );
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 9,
          child: CachedImage(imageUrl: product.imageUrl, fit: BoxFit.cover),
        ),
        Expanded(
          flex: 4,
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
                  style: textTheme(context).displayMedium,
                ),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme(context).titleSmall,
                ),
                product.price != product.finalPrice
                    ? Row(
                        children: [
                          Text(
                            '\$${product.price}',
                            style: textTheme(context).labelSmall!.copyWith(
                              color: colorScheme(context).tertiaryFixedDim,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '\$${product.finalPrice}',
                            style: textTheme(context).labelSmall,
                          ),
                        ],
                      )
                    : Text(
                        '\$${product.price}',
                        style: textTheme(context).labelSmall,
                      ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
