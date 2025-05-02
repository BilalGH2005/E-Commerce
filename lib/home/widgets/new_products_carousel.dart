import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/widgets/new_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewProductsCarousel extends StatelessWidget {
  const NewProductsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final newProducts = context.read<HomeCubit>().newProducts;
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
                    SizedBox(width: 12),
                    Text(
                      'New\nProducts',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: newProducts.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: NewProductCard(
                          product: newProducts[index],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      viewportFraction: HomeCubit.carouselProductsNumber(
                          MediaQuery.sizeOf(context).width),
                      enableInfiniteScroll: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
  }
}
