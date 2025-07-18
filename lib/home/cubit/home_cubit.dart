import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/shop/data/models/filtered_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  bool isLoading = false;

  Future<void> initializeHome() async {
    await _loadInitialProducts();
    // await getNewProducts();
    // await fetchCartItems();
    // await initializeFuzzySearch();
  }

  // ---------------------------------- Home Pane ---------------------------------- //
  PaginatedAsyncValue<List<Product>, void> products =
      PaginatedAsyncValue.loading();
  List<Product>? newProducts;
  int totalProductsCount = 0;
  final endOfList = false;

  int _currentRangeStart = 0;
  final int _pageSize = 2;

  Future<void> _loadInitialProducts() async {
    // getTotalProductCount();
    _currentRangeStart = 0;
    await getProducts();
  }

  Future<void> loadMoreProducts() async {
    _currentRangeStart += _pageSize;
    await getProducts();
  }

  Future<void> getProducts() async {
    isLoading = true;
    emit(HomeLoading());

    final result = await homeRepo.getProducts(
        pageSize: _pageSize, currentRangeStart: _currentRangeStart);

    isLoading = false;

    if (result.isData) {
      products = PaginatedAsyncValue.data(data: [
        ...products.data ?? [],
        ...result.data!,
      ]);

      products = PaginatedAsyncValue.data(
        previous: products,
        data: result.data!,
        combine: (oldData, newData) => [...oldData, ...newData],
      );

      emit(HomeGetProductSuccess());
    } else {
      products = PaginatedAsyncValue.error(error: null, previous: products);
      emit(HomeGetProductFailed());
    }
  }

  // Future<void> getNewProducts() async {
  //   final response = await _supabase.rpc('get_new_products').select('*');
  //   newProducts = response.map((e) => Product.fromJson(e)).toList();
  // }

  static double carouselProductsNumber(double width) {
    if (width >= AppBreakpoints.kDesktopWidth) return 1 / 3.5;
    if (width >= AppBreakpoints.kTabletWidth) return 1 / 2.5;
    return 1 / 1.5;
  }
}
