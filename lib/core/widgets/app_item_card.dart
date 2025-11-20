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
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.pushNamed(
          AppRoutes.productDetails.name,
          pathParameters: {'product_id': product.id},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: CachedImage(imageUrl: product.imageUrl)),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme(
                    context,
                  ).displayMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height:
                      textTheme(context).titleSmall!.fontSize! *
                      textTheme(context).titleSmall!.height! *
                      2,
                  child: Center(
                    child: Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme(context).titleSmall,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                product.price != product.finalPrice
                    ? Row(
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: textTheme(context).labelSmall!.copyWith(
                              color: colorScheme(context).tertiaryFixedDim,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: colorScheme(
                                context,
                              ).tertiaryFixedDim,
                              decorationThickness: isRTL ? 10 : null,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '\$${product.finalPrice.toStringAsFixed(2)}',
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
        ],
      ),
    );
  }
}
