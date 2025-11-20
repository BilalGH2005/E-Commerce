import 'package:e_commerce/core/models/product_preview.dart';
import 'package:flutter/material.dart';

import '../constants/app_breakpoints.dart';
import 'app_item_card.dart';

class AppProductsGridView extends StatelessWidget {
  final int itemCount;
  final List<ProductPreview> products;
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool _isSliver;

  const AppProductsGridView.sliver({
    super.key,
    required this.itemCount,
    required this.products,
  }) : _isSliver = true,
       shrinkWrap = false,
       physics = null,
       padding = EdgeInsets.zero;

  const AppProductsGridView({
    super.key,
    required this.itemCount,
    required this.products,
    this.physics,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.all(10),
  }) : _isSliver = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.widthOf(context);
    if (_isSliver) {
      return SliverGrid.builder(
        gridDelegate: getGridDelegate(width),
        itemCount: itemCount,
        itemBuilder: (context, index) => AppItemCard(products[index]),
      );
    }

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      gridDelegate: getGridDelegate(width),
      itemCount: itemCount,
      itemBuilder: (context, index) => AppItemCard(products[index]),
    );
  }

  static SliverGridDelegateWithMaxCrossAxisExtent getGridDelegate(
    double width,
  ) {
    if (width >= AppBreakpoints.kDesktopWidth) {
      return SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        crossAxisSpacing: 24,
        mainAxisSpacing: 48,
        childAspectRatio: 45 / 100,
      );
    }
    if (width >= AppBreakpoints.kTabletWidth) {
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 225,
        crossAxisSpacing: 16,
        mainAxisSpacing: 32,
        childAspectRatio: 45 / 100,
      );
    }
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      crossAxisSpacing: 8,
      mainAxisSpacing: 16,
      childAspectRatio: 45 / 100,
    );
  }
}
