import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewProductsCarousel extends StatelessWidget {
  const NewProductsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final newProducts = context.read<HomeCubit>().newProducts;
    final width = MediaQuery.sizeOf(context).width;
    return newProducts == null
        ? const SizedBox.shrink()
        : Container(
            height: 200,
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      localization(context).newProducts,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: newProducts.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProductCardBuilder(
                          product: newProducts[index],
                          type: ProductCardType.newProduct,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      viewportFraction: HomeCubit.carouselProductsNumber(width),
                      enableInfiniteScroll: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
  }
}
