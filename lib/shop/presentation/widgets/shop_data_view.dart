import 'package:e_commerce/shop/data/models/product_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shortcuts.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/app_item_card.dart';
import '../../cubit/shop_cubit.dart';

class ShopDataView extends StatelessWidget {
  const ShopDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShopCubit>();
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
                    prefixIcon: const Icon(Icons.search),
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
                          const Icon(Icons.filter_list_sharp),
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
                        right: -4,
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
                                color: colorScheme(context).surface,
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
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 152 + 16,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 8,
                            childAspectRatio: 152 / 314,
                          ),
                      itemBuilder: (context, index) =>
                          AppItemCard(products[index]),
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
