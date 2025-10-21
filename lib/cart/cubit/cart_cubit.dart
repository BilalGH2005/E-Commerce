import 'package:e_commerce/cart/data/repos/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/product.dart';
import '../presentation/widgets/cart_dialog.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  AsyncValue<List<Product>, void>? cartProducts;

  Future<void> fetchCartItems() async {
    cartProducts = AsyncValue.loading();
    emit(CartLoadingStartedState());

    final result = await cartRepo.fetchCartItems();

    if (result.isData) {
      cartProducts = AsyncValue.data(data: result.data!);
      emit(CartItemsFetchedSuccessfullyState());
    } else {
      cartProducts = AsyncValue.error(error: null);
      emit(CartFailedState());
    }
  }

  Future<void> addToCart({required Product product}) async {
    final result = await cartRepo.addToCart(product: product);

    if (result.isData) {
      emit(CartAddedItemSuccessfullyState());
    } else {
      emit(CartFailedState());
    }
  }

  Future<void> removeFromCart({required Product product}) async {
    final result = await cartRepo.removeFromCart(product: product);

    if (result.isData) {
      emit(CartDeletedItemSuccessfullyState());
    } else {
      emit(CartFailedState());
    }
  }

  Future<void> showCartDialog(BuildContext context) async => await showDialog(
        context: context,
        builder: (context) {
          return const CartDialog();
        },
      );
}
