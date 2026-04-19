import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';

class SettingsSectionLabel extends StatelessWidget {
  const SettingsSectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        text,
        style: textTheme(context).bodyMedium?.copyWith(
          letterSpacing: 0.5,
          color: colorScheme(context).onSurfaceVariant,
        ),
      ),
    );
  }
}
