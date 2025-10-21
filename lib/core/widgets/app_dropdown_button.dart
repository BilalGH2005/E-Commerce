import 'package:flutter/material.dart';

import '../utils/shortcuts.dart';

class AppDropdownButton extends StatelessWidget {
  final String? value;
  final void Function(String?)? onChanged;
  final List<String> items;

  const AppDropdownButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.only(left: 12, right: 8),
      filled: true,
      fillColor: colorScheme(context).surfaceContainer,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorScheme(context).tertiary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorScheme(context).primary, width: 2),
      ),
      errorStyle: textTheme(
        context,
      ).displaySmall!.copyWith(color: colorScheme(context).error),
    ),
    isExpanded: true,
    dropdownColor: colorScheme(context).surfaceContainer,
    style: textTheme(context).labelSmall,
    iconDisabledColor: colorScheme(context).secondary,
    borderRadius: BorderRadius.circular(10),
    initialValue: value,
    onChanged: onChanged,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        alignment: Alignment.centerLeft,
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
