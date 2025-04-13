import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/reusable_widgets/reusable_cached_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    final screenHeight = size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.pushNamed(ScreensNames.product, extra: product);
      },
      child: SizedBox(
        width: screenWidth * 0.44,
        height: screenHeight * 0.29,
        child: Card(
          color: Theme.of(context).colorScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableCachedImage(
                imageUrl: product.imageUrl,
                width: double.infinity,
                height: screenHeight * 0.182,
              ),
              Padding(
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
                      "\$${product.price}",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
