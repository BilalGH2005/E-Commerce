import 'package:adaptive_grid/adaptive_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/localization.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_field.dart';
import '../../cubit/shop_cubit.dart';
import 'item_card.dart';

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
                    hintText: localization(context).searchHere,
                    autoFocus: true,
                    onChanged: (newValue) {
                      final newFilters =
                          cubit.draftFilters.copyWith(searchQuery: newValue);
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
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.outlined(
                  style: IconButton.styleFrom(
                    fixedSize: Size(double.infinity, 46),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary),
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
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
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
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
            if (filteredProductModel.products.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      localization(context).noProductsFound,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AdaptiveGrid(
                      verticalSpacing: 12,
                      horizontalSpacing: 12,
                      disableStretch: true,
                      itemCount: filteredProductModel.products.length,
                      minimumItemWidth: 150,
                      itembuilder: (context, index) => ItemCard(
                        filteredProductModel.products[index],
                      ),
                    ),
                  ),
                  if (!cubit.filteredProducts.data!.paginationInfo.isLastPage)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: cubit.isLoadingMore
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  cubit.getMoreFilteredProducts();
                                },
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: () async {
                  return cubit.getFilteredProducts(initialGet: true);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
