import 'package:flutter/material.dart';

import '../../core/utils/duration_extension.dart';
import '../models/json_color.dart';
import '../utils/hex_color.dart';
import '../utils/shortcuts.dart';

class AppColorButton extends StatelessWidget {
  final JsonColor color;
  final bool isSelected;
  final VoidCallback onPressed;

  const AppColorButton({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onPressed,
      child: AnimatedContainer(
        duration: 300.ms,
        padding: isSelected ? const EdgeInsets.all(4) : EdgeInsets.zero,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HexColor(color.hexCode),
          border: Border.all(color: colorScheme(context).tertiary, width: 0.8),
        ),
        child: AnimatedContainer(
          duration: 300.ms,
          padding: isSelected ? const EdgeInsets.all(3) : EdgeInsets.zero,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? colorScheme(context).surface
                : Colors.transparent,
          ),
          child: AnimatedContainer(
            duration: 300.ms,
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor(color.hexCode),
            ),
          ),
        ),
      ),
    );
  }
}
