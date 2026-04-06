import 'package:e_commerce/product_details/model/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/shortcuts.dart';
import '../../../product_details/model/order_details.dart';
import '../../data/repos/cart_repo.dart';
import '../../models/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;

  CartCubit(CartRepo cartRepo) : _cartRepo = cartRepo, super(CartInitial()) {
    getCartItems();
  }

  final couponFieldController = TextEditingController();
  double shippingCost = 0.00;
  bool isCouponLoading = false;
  bool isCartBusy = false;
  double couponDiscount = 0.00;
  final formKey = GlobalKey<FormState>();
  AsyncValue<List<CartItem>, void> cartProducts = AsyncValue.initial();

  Future<void> getCartItems() async {
    cartProducts = AsyncValue.loading();
    emit(CartLoadingStartedState());

    final result = await _cartRepo.getCartItems();

    if (result.isData) {
      cartProducts = AsyncValue.data(data: result.data!);
      emit(CartItemsFetchedSuccessfullyState());
    } else {
      cartProducts = AsyncValue.error(error: null);
      emit(CartFetchFailedState());
    }
  }

  Future<void> addToCart({required ProductDetailsModel product}) async {
    if (isCartBusy) return;
    isCartBusy = true;
    emit(CartStateChanged());

    final previous = List<CartItem>.from(cartProducts.data ?? []);

    // return -1 if product isn't found
    final index = previous.indexWhere(
      (item) =>
          item.productId == product.id &&
          item.pickedColor.id == product.colors[0].id &&
          item.pickedSize.id == product.sizes[0].id,
    );

    List<CartItem> updated = List<CartItem>.from(previous);

    // product is in the list
    if (index != -1) {
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );
    } else {
      updated.add(
        CartItem(
          quantity: 1,
          imageUrl: product.imagesUrls[0],
          newPrice: product.finalPrice,
          oldPrice: product.price,
          productId: product.id,
          pickedSize: product.sizes[0],
          pickedColor: SimpleJsonColor(
            id: product.colors[0].id,
            name: product.colors[0].name,
          ),
          productName: product.name,
        ),
      );
    }

    cartProducts = AsyncValue.data(data: updated);
    emit(CartStateChanged());

    final result = await _cartRepo.addToCart(
      orderDetails: OrderDetails(
        productId: product.id,
        colorId: product.colors[0].id,
        sizeId: product.sizes[0].id,
      ),
    );

    if (result.isError) {
      _revertChange(previous);
    }

    isCartBusy = false;
    emit(CartStateChanged());
  }

  Future<void> removeFromCart({required OrderDetails orderDetails}) async {
    if (isCartBusy) return;
    isCartBusy = true;
    emit(CartStateChanged());

    final previous = List<CartItem>.from(cartProducts.data ?? []);
    List<CartItem> updated = List<CartItem>.from(previous);

    final index = updated.indexWhere(
      (item) =>
          item.productId == orderDetails.productId &&
          item.pickedColor.id == orderDetails.colorId &&
          item.pickedSize.id == orderDetails.sizeId,
    );

    if (index == -1) return;

    if (updated[index].quantity > 1) {
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity - 1,
      );
    } else {
      updated.removeAt(index);
    }

    cartProducts = AsyncValue.data(data: updated);
    emit(CartStateChanged());

    final result = await _cartRepo.removeFromCart(orderDetails: orderDetails);

    if (result.isError) {
      _revertChange(previous);
    }

    isCartBusy = false;
    emit(CartStateChanged());
  }

  Future<void> removeFromCartEntirely({
    required OrderDetails orderDetails,
  }) async {
    if (isCartBusy) return;
    isCartBusy = true;
    emit(CartStateChanged());

    final previous = List<CartItem>.from(cartProducts.data ?? []);
    List<CartItem> updated = List<CartItem>.from(previous);

    updated.removeWhere(
      (item) =>
          item.productId == orderDetails.productId &&
          item.pickedColor.id == orderDetails.colorId &&
          item.pickedSize.id == orderDetails.sizeId,
    );

    cartProducts = AsyncValue.data(data: updated);
    emit(CartStateChanged());

    final result = await _cartRepo.removeFromCartEntirely(
      orderDetails: orderDetails,
    );

    if (result.isError) {
      _revertChange(previous);
    }

    isCartBusy = false;
    emit(CartStateChanged());
  }

  Future<void> getCouponDiscount() async {
    if (!formKey.currentState!.validate()) return;
    isCouponLoading = true;
    emit(CartStateChanged());

    final result = await _cartRepo.getCouponDiscount(
      couponCode: couponFieldController.text.trim(),
    );

    if (result.isData) {
      if (result.data == 0) {
        emit(CartCouponDoesNotExistState());
      } else {
        couponDiscount = result.data!;
        couponFieldController.clear();
        emit(CartCouponAppliedState());
      }
    } else {
      emit(CartFailedState());
    }
    isCouponLoading = false;
    emit(CartStateChanged());
  }

  void changeCoupon(double newValue) {
    couponDiscount = newValue;
    emit(CartStateChanged());
  }

  void onPaymentMethodChanged(double? newValue) {
    shippingCost = newValue!;
    emit(CartStateChanged());
  }

  void _revertChange(List<CartItem> previousList) {
    cartProducts = AsyncValue.data(data: previousList);
    emit(CartFailedState());
  }

  static String? couponFieldValidator({
    required BuildContext context,
    required String? value,
  }) {
    if (value == null || value.trim().isEmpty) {
      return localization(context).putYourCouponCodeHere;
    }
    return null;
  }
}
