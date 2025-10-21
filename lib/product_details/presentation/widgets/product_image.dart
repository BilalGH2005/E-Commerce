import 'package:e_commerce/product_details/presentation/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/cached_image.dart';
import '../../cubit/product_details_cubit.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final imagesUrls = cubit.product.data!.imagesUrls;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 160 / 100,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: cubit.imagesController,
                onPageChanged: cubit.onImagePageChanged,
                itemCount: imagesUrls.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CachedImage(
                    imageUrl: imagesUrls[index],
                    borderRadius: 16,
                  ),
                ),
              ),
              cubit.currentPage != 0
                  ? Positioned(
                      left: 10,
                      child: CustomIconButton(
                        icon: Icons.arrow_back_ios_outlined,
                        onPressed: () {
                          cubit.goToPreviousImage();
                        },
                      ),
                    )
                  : SizedBox.shrink(),
              cubit.currentPage != imagesUrls.length - 1
                  ? Positioned(
                      right: 10,
                      child: CustomIconButton(
                        icon: Icons.arrow_forward_ios_outlined,
                        onPressed: () {
                          cubit.goToNextImage();
                        },
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        SizedBox(height: 12),
        SmoothPageIndicator(
          controller: cubit.imagesController,
          count: imagesUrls.length,
          effect: ExpandingDotsEffect(
            radius: 40,
            dotWidth: 10,
            expansionFactor: 1.2,
            activeDotColor: colorScheme(context).primary,
            dotColor: colorScheme(context).tertiary,
            dotHeight: 10,
          ),
        ),
      ],
    );
  }
}
