import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/json_size.dart';
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

  Future<void> addToCart({required OrderDetails orderDetails}) async {
    if (isCartBusy) return;
    isCartBusy = true;
    emit(CartStateChanged());

    final previous = List<CartItem>.from(cartProducts.data ?? []);

    final index = previous.indexWhere(
      (item) =>
          item.productId == orderDetails.productId &&
          item.pickedColor.id == orderDetails.colorId &&
          item.pickedSize.id == orderDetails.sizeId,
    );

    List<CartItem> updated = List<CartItem>.from(previous);

    if (index != -1) {
      final item = updated[index];
      updated[index] = CartItem(
        quantity: item.quantity + 1,
        imageUrl: item.imageUrl,
        newPrice: item.newPrice,
        oldPrice: item.oldPrice,
        productId: item.productId,
        pickedSize: item.pickedSize,
        pickedColor: item.pickedColor,
        productName: item.productName,
      );
    } else {
      updated.add(
        // API will return correct data after full fetch
        CartItem(
          quantity: 1,
          imageUrl: '',
          newPrice: 0,
          oldPrice: 0,
          productId: orderDetails.productId,
          pickedSize: JsonSize(id: orderDetails.sizeId, name: ''),
          pickedColor: SimpleJsonColor(id: orderDetails.colorId, name: ''),
          productName: '',
        ),
      );
    }

    cartProducts = AsyncValue.data(data: updated);
    emit(CartStateChanged());

    final result = await _cartRepo.addToCart(orderDetails: orderDetails);

    if (!result.isData) {
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

    final item = updated[index];

    if (item.quantity > 1) {
      updated[index] = CartItem(
        quantity: item.quantity - 1,
        imageUrl: item.imageUrl,
        newPrice: item.newPrice,
        oldPrice: item.oldPrice,
        productId: item.productId,
        pickedSize: item.pickedSize,
        pickedColor: item.pickedColor,
        productName: item.productName,
      );
    } else {
      updated.removeAt(index);
    }

    cartProducts = AsyncValue.data(data: updated);
    emit(CartStateChanged());

    final result = await _cartRepo.removeFromCart(orderDetails: orderDetails);

    if (!result.isData) {
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

    if (!result.isData) {
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
