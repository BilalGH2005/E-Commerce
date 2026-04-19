import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_color_button.dart';
import 'package:e_commerce/shop/presentation/controllers/shop_cubit.dart';
import 'package:e_commerce/shop/presentation/widgets/price_range_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../models/product_filters.dart';

class ProductsFiltersBottomSheet extends StatelessWidget {
  const ProductsFiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        final cubit = context.read<ShopCubit>();
        final shopMetadata = cubit.shopMetadata.data!;

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16,
              right: isRTL ? 16 : 0,
              left: isRTL ? 0 : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                        padding: EdgeInsets.only(
                          left: isRTL ? 0 : 8,
                          right: isRTL ? 8 : 0,
                        ),
                        child: ChoiceChip.elevated(
                          label: Text(category.name),
                          selected: isSelected,
                          onSelected: (_) {
                            cubit.updateFilter(
                              cubit.draftFilters.copyWith(
                                categoryId: isSelected ? null : category.id,
                              ),
                            );
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
                        padding: EdgeInsets.only(
                          left: isRTL ? 0 : 8,
                          right: isRTL ? 8 : 0,
                        ),
                        child: ChoiceChip.elevated(
                          label: Text(size.name),
                          selected: isSelected,
                          onSelected: (_) {
                            cubit.updateFilter(
                              cubit.draftFilters.copyWith(
                                sizeId: isSelected ? null : size.id,
                              ),
                            );
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
                        padding: EdgeInsets.only(
                          left: isRTL ? 0 : 8,
                          right: isRTL ? 8 : 0,
                        ),
                        child: AppColorButton(
                          color: color,
                          isSelected: isSelected,
                          onPressed: () {
                            cubit.updateFilter(
                              cubit.draftFilters.copyWith(
                                colorId: isSelected ? null : color.id,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.only(
                    right: isRTL ? 0 : 16,
                    left: isRTL ? 16 : 0,
                  ),
                  child: PriceRangeWidget(),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
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
                    const SizedBox(width: 10),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 11,
                      child: AppButton(
                        onPressed: () {
                          context.pop();
                          cubit.getFilteredProducts();
                        },
                        label: localization(context).applyFilters,
                        labelWidget: Text(
                          localization(context).applyFilters,
                          style: textTheme(context).bodyMedium,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
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
