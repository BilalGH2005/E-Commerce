import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';

class SettingsOpaqueCard extends StatelessWidget {
  const SettingsOpaqueCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: colorScheme(context).surfaceContainerHighest.withAlpha(127),
        border: Border.all(color: colorScheme(context).tertiary),
        boxShadow: [
          // BoxShadow(
          //   color: colorScheme(context).shadow.withAlpha(30),
          //   blurRadius: 20,
          //   offset: const Offset(0, 8),
          // ),
        ],
      ),
      child: child,
    );
  }
}
