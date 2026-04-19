import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.trailing,
  });

  final String text;
  final Widget? icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        child: Row(
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 16),
            Expanded(
              child: Text(text, style: textTheme(context).displayMedium),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
