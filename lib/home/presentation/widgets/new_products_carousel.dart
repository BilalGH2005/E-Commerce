import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/core/models/product_preview.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_item_card.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class NewProductsCarousel extends StatelessWidget {
  final List<ProductPreview> newProducts;

  const NewProductsCarousel(this.newProducts, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 450,
      child: Column(
        children: [
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                localization(context).justIn,
                style: textTheme(context).displayLarge!.copyWith(
                  color: colorScheme(context).inverseSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: CarouselSlider.builder(
              itemCount: newProducts.length,
              itemBuilder: (context, index, realIndex) {
                return AppItemCard(newProducts[index]);
              },
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                viewportFraction: HomeCubit.carouselProductsNumber(width),
                padEnds: false,
                enableInfiniteScroll: true,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
