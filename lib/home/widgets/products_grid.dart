import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  const ProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) => SliverAnimatedGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 164,
          mainAxisExtent: 250,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        initialItemCount: products.length,
        itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: ProductCard(
              product: products[index],
            ),
          ),
        ),
      );
}
