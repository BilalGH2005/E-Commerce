import 'package:flutter/material.dart';

class ReusableDropdownButton extends StatelessWidget {
  final String? value;
  final void Function(String?)? onChanged;
  final List<String> items;
  const ReusableDropdownButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 12, right: 8),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Theme.of(context).colorScheme.error)),
      isExpanded: true,
      dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
      style: Theme.of(context).textTheme.labelSmall,
      iconDisabledColor: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(10),
      value: value,
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
}
