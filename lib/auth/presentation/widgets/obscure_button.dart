import 'package:flutter/material.dart';

class ObscureButton extends StatelessWidget {
  final bool isObscure;
  final VoidCallback onPressed;

  const ObscureButton(
      {super.key, required this.isObscure, required this.onPressed});

  @override
  Widget build(BuildContext context) => IconButton(
        splashRadius: 20,
        onPressed: onPressed,
        focusNode: FocusNode(skipTraversal: true),
        icon: isObscure
            ? Icon(Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.tertiaryFixed)
            : Icon(
                Icons.remove_red_eye_outlined,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
      );
}
