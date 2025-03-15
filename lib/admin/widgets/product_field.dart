import 'package:flutter/material.dart';

class ProductField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  const ProductField(
      {super.key,
      required this.controller,
      required this.label,
      this.prefixIcon,
      this.validator,
      this.keyboardType,
      this.maxLines});

  @override
  Widget build(BuildContext context) => TextFormField(
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: Theme.of(context).textTheme.labelSmall,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        alignLabelWithHint: true,
        fillColor: Theme.of(context).colorScheme.onSurface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFFA8A8A9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFFA8A8A9),
          ),
        ),
        filled: true,
        label: Text(
          label,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ),
      validator: validator);
}
