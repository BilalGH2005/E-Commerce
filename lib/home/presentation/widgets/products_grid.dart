import 'package:e_commerce/shop/data/models/filtered_products_model.dart';
import 'package:flutter/material.dart';

import '../../../shop/presentation/widgets/item_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;

  const ProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) => SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 210,
          mainAxisExtent: 325,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => ItemCard(
          products[index],
        ),
      );
}
