import 'package:flutter/material.dart';

import '../utils/shortcuts.dart';

class AppDropdownButton extends StatelessWidget {
  final String? value;
  final void Function(String?)? onChanged;
  final List<String> items;
  final Map<String, String>? itemLabels;

  const AppDropdownButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.itemLabels,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = colorScheme(context);
    final textStyles = textTheme(context);
    final isEnabled = onChanged != null;
    final radius = BorderRadius.circular(14);
    final fieldTextStyle =
        Theme.of(context).dropdownMenuTheme.textStyle ??
        textStyles.labelSmall!.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        );
    final selectedBackgroundColor = scheme.inversePrimary.withAlpha(16);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: scheme.inverseSurface.withAlpha(14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: DropdownMenu<String>(
        enabled: isEnabled,
        menuHeight: 280,
        requestFocusOnTap: false,
        enableFilter: false,
        enableSearch: false,
        textStyle: fieldTextStyle,
        initialSelection: value,
        onSelected: onChanged,
        expandedInsets: EdgeInsets.zero,
        trailingIcon: _DropdownChevron(
          backgroundColor: isEnabled
              ? scheme.primary.withAlpha(18)
              : scheme.tertiary.withAlpha(16),
          icon: Icons.keyboard_arrow_down_rounded,
          iconColor: isEnabled ? scheme.primary : scheme.tertiaryFixedDim,
        ),
        selectedTrailingIcon: _DropdownChevron(
          backgroundColor: isEnabled
              ? scheme.primary.withAlpha(18)
              : scheme.tertiary.withAlpha(16),
          icon: Icons.keyboard_arrow_up_rounded,
          iconColor: isEnabled ? scheme.primary : scheme.tertiaryFixedDim,
        ),
        dropdownMenuEntries: items.map((item) {
          final label = itemLabels?[item] ?? item;
          final isSelected = item == value;
          return DropdownMenuEntry<String>(
            value: item,
            label: label,
            labelWidget: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailingIcon: isSelected
                ? Icon(Icons.check_rounded, size: 16, color: scheme.primary)
                : null,
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                EdgeInsetsDirectional.only(
                  start: 12,
                  end: 10,
                  top: 10,
                  bottom: 10,
                ),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor: WidgetStatePropertyAll(
                isSelected ? selectedBackgroundColor : Colors.transparent,
              ),
              foregroundColor: WidgetStatePropertyAll(
                isSelected ? scheme.primary : scheme.onSurface,
              ),
              textStyle: WidgetStatePropertyAll(
                fieldTextStyle.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              iconColor: WidgetStatePropertyAll(
                isSelected ? scheme.primary : scheme.onSurface,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DropdownChevron extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  const _DropdownChevron({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }
}
