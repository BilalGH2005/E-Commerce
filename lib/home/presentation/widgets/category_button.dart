import 'package:e_commerce/core/constants/app_routes.dart';
import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/cached_image.dart';
import 'package:e_commerce/home/data/models/home_metadata_model.dart';
import 'package:e_commerce/shop/cubit/shop_cubit.dart';
import 'package:e_commerce/shop/data/models/product_filters.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.pushNamed(AppRoutes.shop.name);
        final newFilters = ProductFilters.empty().copyWith(
          categoryId: category.id,
        );
        serviceLocator<ShopCubit>()
          ..updateFilter(newFilters)
          ..getFilteredProducts(initialGet: true);
      },
      child: Column(
        children: [
          CachedImage(
            imageUrl: category.imageUrl,
            height: 152,
            width: 152,
            borderRadius: 200,
          ),
          SizedBox(height: 12),
          Text(
            category.name,
            style: textTheme(context).bodyMedium!.copyWith(
              fontSize: 14,
              color: colorScheme(context).inverseSurface,
            ),
          ),
        ],
      ),
    );
  }
}
