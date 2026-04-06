import 'package:e_commerce/core/constants/app_links.dart';
import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/dependency_injection.dart';
import '../../data/repos/payment_repo.dart';
import '../widgets/successful_payment_dialog.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(PaymentRepo paymentRepo)
    : _paymentRepo = paymentRepo,
      super(PaymentInitial());

  final PaymentRepo _paymentRepo;
  bool isLoading = false;

  Future<void> _initPaymentSheet({
    required BuildContext context,
    required String clientSecret,
  }) async {
    await serviceLocator<Stripe>().initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'customer',
        appearance: PaymentSheetAppearance().copyWith(
          colors: PaymentSheetAppearanceColors().copyWith(
            primary: colorScheme(context).primary,
            background: colorScheme(context).surface,
            componentBackground: colorScheme(context).surfaceContainer,
            componentText: colorScheme(context).inverseSurface,
            componentDivider: colorScheme(context).tertiary,
            primaryText: colorScheme(context).primary,
            secondaryText: colorScheme(context).inverseSurface,
          ),
        ),
        returnURL: AppLinks.signUpRedirectDeepLink,
      ),
    );
  }

  Future<void> presentPaymentSheet({
    required double amount,
    required BuildContext context,
  }) async {
    String? clientSecret;
    isLoading = true;
    emit(PaymentStateChanged());
    try {
      final result = await _paymentRepo.createPaymentIntent(amount: amount);
      if (result.isData) {
        clientSecret = result.data!;
        await _initPaymentSheet(context: context, clientSecret: clientSecret);
      } else {
        throw (result.error!);
      }
      await serviceLocator<Stripe>().presentPaymentSheet();
      emit(PaymentSuccessful());
    } catch (_) {
      emit(PaymentFailed());
    }
    isLoading = false;
    emit(PaymentStateChanged());
  }

  void showSuccessfulPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SuccessfulPaymentDialog(),
    );
  }
}
