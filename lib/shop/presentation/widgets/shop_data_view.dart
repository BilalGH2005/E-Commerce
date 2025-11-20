import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/widgets/app_products_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.gen.dart';
import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_field.dart';
import '../../models/product_filters.dart';
import '../controllers/shop_cubit.dart';

class ShopDataView extends StatelessWidget {
  const ShopDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShopCubit>();
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: AppField(
                    controller: cubit.queryFieldController,
                    hintText: localization(context).searchForProducts,
                    autoFocus: true,
                    onChanged: (newValue) {
                      final newFilters = cubit.draftFilters.copyWith(
                        searchQuery: newValue,
                      );
                      cubit.updateFilter(newFilters);
                    },
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      cubit.getFilteredProducts();
                    },
                    prefixIcon: SvgPicture.asset(
                      Assets.icons.search,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                        colorScheme(context).inverseSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    suffixIcon: cubit.isQueryFieldEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              cubit.queryFieldController.clear();
                              cubit.updateFilter(
                                cubit.draftFilters.copyWith(searchQuery: null),
                              );
                            },
                          ),
                    fillColor: colorScheme(context).surface,
                  ),
                ),
                const SizedBox(width: 10),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton.outlined(
                      style: IconButton.styleFrom(
                        fixedSize: Size(double.infinity, 46),
                        side: BorderSide(color: colorScheme(context).tertiary),
                        backgroundColor: colorScheme(context).surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        cubit.showProductsFiltersBottomSheet(context: context);
                      },
                      icon: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icons.filters,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                              colorScheme(context).tertiaryFixed,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            localization(context).filters,
                            style: textTheme(context).displaySmall,
                          ),
                        ],
                      ),
                    ),
                    if (cubit.appliedFilters.withoutPage() !=
                        ProductFilters.empty().withoutPage())
                      Positioned(
                        right: isRTL ? null : -4,
                        left: isRTL ? -4 : null,
                        top: -4,
                        child: Container(
                          width: 50,
                          height: 15,
                          decoration: BoxDecoration(
                            color: colorScheme(context).primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Center(
                            child: Text(
                              localization(context).applied,
                              style: textTheme(context).titleSmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        AsyncValueBuilder(
          value: cubit.filteredProducts,
          loading: (context) => const SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          data: (context, filteredProductModel) {
            final products = filteredProductModel.products;

            if (products.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      localization(context).noProductsFound,
                      style: textTheme(context).headlineMedium,
                    ),
                  ),
                ),
              );
            }

            return SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppProductsGridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      products: products,
                    ),
                  ),
                  if (!filteredProductModel.paginationInfo.isLastPage)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: cubit.isLoadingMore
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: cubit.getMoreFilteredProducts,
                                child: Text(localization(context).seeMore),
                              ),
                      ),
                    ),
                ],
              ),
            );
          },
          error: (context, error) => SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: AppErrorWidget(
                error: localization(context).somethingWentWrong,
                labelWidget: Text(
                  localization(context).retry,
                  style: textTheme(context).bodyMedium,
                ),
                onPressed: () async {
                  await cubit.getFilteredProducts(initialGet: true);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
