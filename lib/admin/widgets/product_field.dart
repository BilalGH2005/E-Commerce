import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/cubit/app_cubit.dart';

class ProductField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  const ProductField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        onTapOutside: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onFieldSubmitted: onSubmitted,
        style: Theme.of(context).textTheme.displaySmall,
        textInputAction: textInputAction,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          filled: true,
          label: Text(
            label,
            style: TextStyle(
                fontFamily: context.watch<AppCubit>().isArabic!
                    ? 'Tajawal'
                    : 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ),
      );
}
