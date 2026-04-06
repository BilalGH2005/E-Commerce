import 'package:e_commerce/payment/presentation/widgets/successful_payment_animation.dart';
import 'package:flutter/material.dart';

class SuccessfulPaymentDialog extends StatelessWidget {
  const SuccessfulPaymentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: SizedBox(
        width: 330,
        height: 200,
        child: SuccessfulPaymentAnimation(),
      ),
    );
  }
}
