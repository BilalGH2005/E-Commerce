import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';

class ShippingMethodRadio extends StatelessWidget {
  final double value;
  final String title;

  const ShippingMethodRadio({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme(context).inverseSurface),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Radio(value: value),
              Text(
                title,
                style: textTheme(
                  context,
                ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: textTheme(
              context,
            ).displaySmall!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
