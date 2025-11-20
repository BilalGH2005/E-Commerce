import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/dependency_injection.dart';
import '../../data/repos/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(PaymentRepo paymentRepo)
    : _paymentRepo = paymentRepo,
      super(PaymentInitial());

  final PaymentRepo _paymentRepo;

  String? _clientSecret;

  Future<void> createPaymentIntent({required double amount}) async {
    final result = await _paymentRepo.createPaymentIntent(amount: amount);

    if (result.isData) {
      _clientSecret = result.data!;
      emit(PaymentStateChanged());
      await _initPaymentSheet();
    } else {
      emit(PaymentFailedState());
    }
  }

  Future<void> _initPaymentSheet() async {
    await serviceLocator<Stripe>().initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: _clientSecret,
        merchantDisplayName: 'Flutter Developer',
      ),
    );
  }
}
