import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget label;
  const AppButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4 /*10*/),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          disabledBackgroundColor:
              Theme.of(context).colorScheme.surfaceContainer,
        ),
        onPressed: onPressed,
        child: label,
      );
}
