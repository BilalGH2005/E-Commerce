import 'package:e_commerce/home/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const ProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 164,
        mainAxisExtent: 250,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      initialItemCount: products.length,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: ProductCard(
              product: Product.fromProducts(products[index]),
            ),
          ),
        );
      },
    );
  }
}
