import 'package:flutter/material.dart';

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
  final double borderRadius;
  final bool? autoFocus;
  final String? hintText;
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
    this.borderRadius = 10,
    this.autoFocus,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        onTapOutside: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        autofocus: autoFocus ?? false,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        style: Theme.of(context).textTheme.displaySmall,
        textInputAction: textInputAction,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          label: label != null ? Text(label!) : null,
          hintText: hintText,
        ),
      );
}
