import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:e_commerce/core/utils/snackbar_util.dart';
import 'package:e_commerce/home/models/product.dart';
import 'package:e_commerce/home/widgets/cart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final SupabaseClient _supabase = Supabase.instance.client;

  // ---------------------------------- Home Pane ---------------------------------- //
  late AsyncValue<List<Product>> products;
  List<Product>? newProducts;

  Future<void> fetchProducts() async {
    products = AsyncValue.loading();
    emit(HomeStateChanged());

    try {
      final response = await _supabase.from('products').select('*');
      products = AsyncValue.data(
          data:
              (response as List).map((e) => Product.fromProducts(e)).toList());
      newProducts = getNewProducts();
    } catch (exception) {
      products = AsyncValue.error(error: exception.toString());
    } finally {
      emit(HomeStateChanged());
    }
  }

  List<Product>? getNewProducts() {
    return products.data!
        .where(
            (product) => product.addedAt.isAfter(DateTime.now().subtract(30.d)))
        .toList();
  }

  static double carouselProductsNumber(double width) {
    final deviceType = getDeviceType(width);
    if (deviceType == DeviceType.mobile) return 1 / 1.5;
    if (deviceType == DeviceType.tablet) return 1 / 2.5;
    return 1 / 3.5;
  }

  // ---------------------------------- Cart Pane ---------------------------------- //
  AsyncValue<List<Product>>? cartProducts;

  Future<void> fetchCartItems() async {
    cartProducts = AsyncValue.loading();
    emit(CartStateChanged());

    try {
      final response = await _supabase
          .from('cart_items')
          .select('*, products(*)')
          .eq('user_id', _supabase.auth.currentUser!.id);
      cartProducts = AsyncValue.data(
          data: (response as List)
              .map((item) => Product.fromProducts(item['products']))
              .toList());
    } catch (exception) {
      cartProducts = AsyncValue.error(error: exception.toString());
    } finally {
      emit(CartStateChanged());
    }
  }

  Future<void> addToCart(
      {required BuildContext context, required Product product}) async {
    try {
      await _supabase.from('cart_items').insert({
        "product_id": product.id,
        "user_id": _supabase.auth.currentUser!.id
      });
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
    }
  }

  Future<void> removeFromCart(
      {required BuildContext context, required Product product}) async {
    try {
      await _supabase
          .from('cart_items')
          .delete()
          .eq(_supabase.auth.currentUser!.id, product.id);
    } catch (exception) {
      SnackBarUtil.showErrorSnackBar(context, exception.toString());
    }
  }

  Future<void> showCartDialog(BuildContext context) async => await showDialog(
        context: context,
        builder: (context) {
          return const CartDialog();
        },
      );

// ---------------------------------- Search Pane ---------------------------------- //
  AsyncValue<List<Product>> searchProductsList = AsyncValue.data(data: []);
  final TextEditingController searchController = TextEditingController();
  late Fuzzy _fuzzy;

  Future<void> initializeFuzzySearch() async {
    _fuzzy = Fuzzy<Product>(
      products.data!,
      options: FuzzyOptions(
        keys: [
          WeightedKey<Product>(
            name: 'name',
            weight: 0.6,
            getter: (product) => product.name,
          ),
          WeightedKey<Product>(
            name: 'description',
            weight: 0.3,
            getter: (product) => product.description,
          ),
          WeightedKey<Product>(
            name: 'category',
            weight: 0.1,
            getter: (product) => product.category,
          ),
        ],
        threshold: 0.3,
      ),
    );
    searchProductsList = AsyncValue.data(data: products.data!);
    emit(SearchStateChanged());
  }

  void searchProducts(String query) {
    searchProductsList = AsyncValue.loading();
    emit(SearchStateChanged());

    try {
      final results = _fuzzy.search(query);
      searchProductsList =
          AsyncValue.data(data: results.map((e) => e.item as Product).toList());
    } catch (exception) {
      searchProductsList = AsyncValue.error(error: exception.toString());
    } finally {
      emit(SearchStateChanged());
    }
  }

  static int searchScreenColumns(double width) {
    final deviceType = getDeviceType(width);
    if (deviceType == DeviceType.mobile) return 1;
    if (deviceType == DeviceType.tablet) return 2;
    return 3;
  }
}
