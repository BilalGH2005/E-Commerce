import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';

class QuantityModifierWidget extends StatelessWidget {
  const QuantityModifierWidget({
    super.key,
    required this.quantity,
    required this.decrementEvent,
    required this.incrementEvent,
  });

  final int quantity;
  final void Function()? decrementEvent;
  final void Function()? incrementEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
      ),
      width: 84,
      height: 25,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: decrementEvent,
              child: Icon(Icons.remove, size: 20),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
                style: textTheme(
                  context,
                ).displayMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: incrementEvent,
              child: Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
