import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/product_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/reusable_widgets/reusable_cached_image.dart';
import '../widgets/custom_button.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: const ProductAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableCachedImage(
              imageUrl: product.imageUrl,
              height: screenHeight * 0.3,
              width: double.infinity,
            ),
            Text(
              product.name,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface),
            ),
            Text(
              AppLocalizations.of(context)!.productDetails,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Row(
              children: [
                CustomButton(
                  colors: [Color(0xFF0B3689), Color(0xFF3F92FF)],
                  label: AppLocalizations.of(context)!.goToCart,
                  icon: Icons.shopping_cart_outlined,
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                CustomButton(
                  colors: [Color(0xFF31B769), Color(0xFF71F9A9)],
                  label: AppLocalizations.of(context)!.buyNow,
                  icon: Icons.touch_app_outlined,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
