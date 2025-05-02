import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:flutter/material.dart';

class NewProductCard extends StatelessWidget {
  final Product product;
  const NewProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Banner(
      message: localization(context).newProduct,
      location: BannerLocation.topStart,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
}
