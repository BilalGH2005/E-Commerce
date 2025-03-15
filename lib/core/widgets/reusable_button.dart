import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget label;
  const ReusableButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4 /*10*/),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary),
        onPressed: onPressed,
        child: label);
  }
}
