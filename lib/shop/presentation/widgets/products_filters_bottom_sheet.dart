import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/shop/cubit/shop_cubit.dart';
import 'package:e_commerce/shop/data/models/product_filters.dart';
import 'package:e_commerce/shop/presentation/widgets/color_button.dart';
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
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  localization(context).category,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopMetadata.categories.length,
                    itemBuilder: (context, index) {
                      final category = shopMetadata.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip.elevated(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          label: Text(category.name),
                          selected:
                              cubit.draftFilters.categoryId == category.id,
                          onSelected: (selected) {
                            final newCategoryId = selected ? category.id : null;
                            final newFilters = cubit.draftFilters
                                .copyWith(categoryId: newCategoryId);
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopMetadata.sizes.length,
                    itemBuilder: (context, index) {
                      final size = shopMetadata.sizes[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip.elevated(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          label: Text(size.name),
                          selected: cubit.draftFilters.sizeId == size.id,
                          onSelected: (selected) {
                            final newSizeId = selected ? size.id : null;
                            final newFilters =
                                cubit.draftFilters.copyWith(sizeId: newSizeId);
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopMetadata.colors.length,
                    itemBuilder: (_, index) {
                      final color = shopMetadata.colors[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ColorButton(color),
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
                          style: Theme.of(context).textTheme.bodyMedium,
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
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                        ),
                        child: Text(
                          localization(context).reset,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onPressed: () {
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
