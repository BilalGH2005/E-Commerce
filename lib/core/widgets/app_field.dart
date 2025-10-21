import 'package:flutter/material.dart';

import '../utils/shortcuts.dart';

class AppField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool? isObscure;
  final Widget? suffixIcon;
  final bool? autoFocus;
  final String? hintText;
  final Color? fillColor;

  const AppField({
    super.key,
    required this.controller,
    this.label,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.isObscure,
    this.suffixIcon,
    this.autoFocus,
    this.hintText,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    onTapOutside: (PointerDownEvent event) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    autofocus: autoFocus ?? false,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    style: textTheme(context).displaySmall,
    textInputAction: textInputAction,
    obscureText: isObscure ?? false,
    maxLines: (isObscure ?? false) ? 1 : maxLines,
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      alignLabelWithHint: true,
      fillColor: fillColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: colorScheme(context).tertiary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5, color: colorScheme(context).primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: colorScheme(context).tertiary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5, color: colorScheme(context).error),
      ),
      label: label != null ? Text(label!) : null,
      hintText: hintText,
    ),
  );
}
