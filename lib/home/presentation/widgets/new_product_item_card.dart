import 'package:e_commerce/core/models/product_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/cached_image.dart';

class NewProductItemCard extends StatelessWidget {
  final ProductPreview product;

  const NewProductItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => context.pushNamed(
      AppRoutes.productDetails.name,
      pathParameters: {'product_id': product.id},
    ),
    child: Banner(
      message: localization(context).newProduct,
      location: BannerLocation.topStart,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorScheme(context).surface,
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
      ),
    ),
  );
}
