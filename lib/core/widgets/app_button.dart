import 'package:flutter/material.dart';

import '../utils/shortcuts.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget labelWidget;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.labelWidget,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4 /*10*/),
      ),
      backgroundColor: colorScheme(context).primary,
      disabledBackgroundColor: colorScheme(context).surfaceContainer,
    ),
    onPressed: onPressed,
    child: labelWidget,
  );
}
