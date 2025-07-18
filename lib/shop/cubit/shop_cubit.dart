import 'package:e_commerce/shop/data/models/filtered_products_model.dart';
import 'package:e_commerce/shop/data/models/shop_metadata_model.dart';
import 'package:e_commerce/shop/data/repos/shop_repo.dart';
import 'package:e_commerce/shop/presentation/widgets/products_filters_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/product_filters.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final ShopRepo shopRepo;

  ShopCubit(this.shopRepo) : super(ShopInitial()) {
    getShopMetadata();
    getFilteredProducts(initialGet: true);
    queryFieldController.addListener(_onQueryChanged);
  }

  void _onQueryChanged() {
    final currentEmpty = queryFieldController.text.isEmpty;
    if (currentEmpty != isQueryFieldEmpty) {
      isQueryFieldEmpty = currentEmpty;
      emit(ShopStateChanged());
    }
  }

  ProductFilters draftFilters = ProductFilters.empty();
  ProductFilters appliedFilters = ProductFilters.empty();
  final queryFieldController = TextEditingController();
  bool isQueryFieldEmpty = true;
  bool isNewFiltersApplied = true;

  AsyncValue<ShopMetadata, String> shopMetadata = AsyncValue.initial();

  Future<void> getShopMetadata() async {
    shopMetadata = AsyncValue.loading();
    emit(ShopStateChanged());

    final result = await shopRepo.getShopMetadata();

    if (result.isData) {
      shopMetadata = AsyncValue.data(data: result.data!);
    } else {
      shopMetadata = AsyncValue.error(error: result.error!);
    }
    emit(ShopStateChanged());
  }

  void updateFilter(ProductFilters filters) {
    if (draftFilters == filters) return;
    draftFilters = filters.copyWith(page: 1);

    emit(ShopStateChanged());
  }

  PaginatedAsyncValue<FilteredProductsModel, String> filteredProducts =
      PaginatedAsyncValue.initial();

  Future<void> getFilteredProducts({bool initialGet = false}) async {
    final filtersUnchanged =
        draftFilters.withoutPage() == appliedFilters.withoutPage();

    if (!initialGet && filtersUnchanged) return;

    final filters = draftFilters.copyWith(page: 1);
    filteredProducts = PaginatedAsyncValue.loading();
    emit(ShopStateChanged());

    final result = await shopRepo.getFilteredProducts(filters: filters);

    if (result.isData) {
      filteredProducts = PaginatedAsyncValue.data(data: result.data!);
      appliedFilters = filters.copyWith(page: 2);
    } else {
      filteredProducts = PaginatedAsyncValue.error(error: result.error!);
    }

    emit(ShopStateChanged());
  }

  bool isLoadingMore = false;

  Future<void> getMoreFilteredProducts() async {
    final nextPage = appliedFilters.page;
    final filtersForNextPage = appliedFilters.copyWith(page: nextPage);

    isLoadingMore = true;
    emit(ShopStateChanged());

    final result =
        await shopRepo.getFilteredProducts(filters: filtersForNextPage);

    if (result.isData) {
      filteredProducts = PaginatedAsyncValue.data(
        previous: filteredProducts,
        data: result.data!,
        combine: (oldData, newData) => FilteredProductsModel(
          products: [...oldData.products, ...newData.products],
          paginationInfo: newData.paginationInfo,
        ),
      );
      appliedFilters = filtersForNextPage.copyWith(page: nextPage + 1);
    } else {
      emit(ShopLoadingMoreFailed());
    }

    isLoadingMore = false;
    emit(ShopStateChanged());
  }

  Future<void> showProductsFiltersBottomSheet(
      {required BuildContext context}) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: this,
          child: ProductsFiltersBottomSheet(),
        );
      },
    ).then(
      (_) {
        getFilteredProducts();
      },
    );
  }

  @override
  Future<void> close() {
    queryFieldController.dispose();
    return super.close();
  }
}

extension ProductFiltersWithoutPage on ProductFilters {
  ProductFilters withoutPage() => copyWith(page: 1);
}
