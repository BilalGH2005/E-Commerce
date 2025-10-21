import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_color_button.dart';
import 'package:e_commerce/shop/cubit/shop_cubit.dart';
import 'package:e_commerce/shop/data/models/product_filters.dart';
import 'package:e_commerce/shop/presentation/widgets/price_range_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsFiltersBottomSheet extends StatelessWidget {
  const ProductsFiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        final cubit = context.read<ShopCubit>();
        final shopMetadata = cubit.shopMetadata.data!;
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.65,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    localization(context).filters,
                    style: textTheme(context).labelMedium!.copyWith(
                      color: colorScheme(context).inverseSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  localization(context).category,
                  style: textTheme(context).headlineMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopMetadata.categories.length,
                    itemBuilder: (context, index) {
                      final category = shopMetadata.categories[index];
                      final isSelected =
                          cubit.draftFilters.categoryId == category.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip.elevated(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          label: Text(category.name),
                          selected: isSelected,
                          onSelected: (_) {
                            final newCategoryId = isSelected
                                ? null
                                : category.id;
                            final newFilters = cubit.draftFilters.copyWith(
                              categoryId: newCategoryId,
                            );
                            cubit.updateFilter(newFilters);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  localization(context).size,
                  style: textTheme(context).headlineMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopMetadata.sizes.length,
                    itemBuilder: (context, index) {
                      final size = shopMetadata.sizes[index];
                      final isSelected = cubit.draftFilters.sizeId == size.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip.elevated(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          label: Text(size.name),
                          selected: isSelected,
                          onSelected: (_) {
                            final newSizeId = isSelected ? null : size.id;
                            final newFilters = cubit.draftFilters.copyWith(
                              sizeId: newSizeId,
                            );
                            cubit.updateFilter(newFilters);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  localization(context).color,
                  style: textTheme(context).headlineMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopMetadata.colors.length,
                    itemBuilder: (_, index) {
                      final color = shopMetadata.colors[index];
                      final isSelected = cubit.draftFilters.colorId == color.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AppColorButton(
                          color: color,
                          isSelected: isSelected,
                          onPressed: () {
                            final newColorId = isSelected ? null : color.id;
                            final newFilters = cubit.draftFilters.copyWith(
                              colorId: newColorId,
                            );
                            cubit.updateFilter(newFilters);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                PriceRangeWidget(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: AppButton(
                        onPressed: () async {
                          context.pop();
                          await cubit.getFilteredProducts();
                        },
                        labelWidget: Text(
                          localization(context).applyFilters,
                          style: textTheme(context).bodyMedium,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4 /*10*/),
                          ),
                          backgroundColor: colorScheme(context).tertiary,
                        ),
                        child: Text(
                          localization(context).reset,
                          style: textTheme(context).bodyMedium,
                        ),
                        onPressed: () {
                          context.pop();
                          cubit.updateFilter(ProductFilters.empty());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
