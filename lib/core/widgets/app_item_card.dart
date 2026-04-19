import 'package:e_commerce/core/models/product_preview.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_routes.dart';

class AppItemCard extends StatefulWidget {
  final ProductPreview product;

  const AppItemCard(this.product, {super.key});

  @override
  State<AppItemCard> createState() => _AppItemCardState();
}

class _AppItemCardState extends State<AppItemCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    final product = widget.product;
    final borderRadius = BorderRadius.circular(12);

    return AnimatedScale(
      scale: _pressed ? 0.98 : 1,
      duration: const Duration(milliseconds: 120),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: CachedImage(imageUrl: product.imageUrl)),
                const SizedBox(height: 12),
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
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 12),
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
                                const SizedBox(width: 10),
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
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: borderRadius,
                  splashColor: colorScheme(context).tertiary.withAlpha(45),
                  highlightColor: colorScheme(context).tertiary.withAlpha(24),
                  onTapDown: (_) => _setPressed(true),
                  onTapCancel: () => _setPressed(false),
                  onTapUp: (_) => _setPressed(false),
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.productDetails.name,
                      pathParameters: {'product_id': product.id},
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
