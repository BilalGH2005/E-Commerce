import 'package:e_commerce/core/models/product_preview.dart';
import 'package:flutter/material.dart';

import '../constants/app_breakpoints.dart';
import 'app_item_card.dart';

class AppProductsGridView extends StatelessWidget {
  final int itemCount;
  final List<ProductPreview> products;
  final EdgeInsets padding;
  final bool _isSliver;

  const AppProductsGridView.sliver({
    super.key,
    required this.itemCount,
    required this.products,
  }) : _isSliver = true,
       padding = EdgeInsets.zero;

  const AppProductsGridView({
    super.key,
    required this.itemCount,
    required this.products,
    this.padding = const EdgeInsets.all(10),
  }) : _isSliver = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.widthOf(context);

    final delegate = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: getMaxCrossAxisExtent(width),
      crossAxisSpacing: getCrossAxisSpacing(width),
      mainAxisSpacing: getMainAxisSpacing(width),
      childAspectRatio: 45 / 100,
    );
    if (_isSliver) {
      return SliverGrid.builder(
        gridDelegate: delegate,
        itemCount: itemCount,
        itemBuilder: (context, index) => AppItemCard(products[index]),
      );
    }

    return GridView.builder(
      padding: padding,
      gridDelegate: delegate,
      itemCount: itemCount,
      itemBuilder: (context, index) => AppItemCard(products[index]),
    );
  }

  static double getScreenPadding(double width) {
    if (width >= AppBreakpoints.kDesktopWidth) return 160;
    if (width >= AppBreakpoints.kTabletWidth) return 80;
    return 32;
  }

  static double getMaxCrossAxisExtent(double width) {
    if (width >= AppBreakpoints.kDesktopWidth) return 250;
    if (width >= AppBreakpoints.kTabletWidth) return 225;
    return 200;
  }

  static double getMainAxisSpacing(double width) {
    if (width >= AppBreakpoints.kDesktopWidth) return 48;
    if (width >= AppBreakpoints.kTabletWidth) return 32;
    return 16;
  }

  static double getCrossAxisSpacing(double width) {
    if (width >= AppBreakpoints.kDesktopWidth) return 24;
    if (width >= AppBreakpoints.kTabletWidth) return 16;
    return 8;
  }
}
